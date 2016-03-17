defmodule ExrmDeploy.Mixin do
  defmacro __using__(_) do
    quote do
      import Logger, only: [info: 1, error: 1]

      defp project, do: Mix.Project.get().project
      defp app,     do: project[:app]
      defp config,  do: Application.get_env(app, :deployment)

      defp copy({:ok, file}) do
        System.cmd("scp", ["-P#{config[:port]}", "#{file}", "#{config[:username]}@#{config[:server]}:#{app}/"])
        |> process_cmd
      end
      defp copy({:error, _} = err), do: err

      defp unpack({:ok, file}), do: sshexec("cd #{app} && tar xfz *.tar.gz")
      defp unpack({:error, _} = err), do: err

      defp activate({:ok, file}), do: appexec("upgrade #{project[:version]}")
      defp activate({:error, _} = err), do: err

      defp appexec(cmd), do: sshexec("cd #{app} && bin/#{app} #{cmd}")
      defp sshexec(cmd) do
        System.cmd("ssh", ["-p#{config[:port]}", "#{config[:username]}@#{config[:server]}", "bash -lc '#{cmd}'"])
        |> process_cmd
      end

      # FIXME normalization needed? -> System.cmd into: Collectable
      defp process_cmd({stdout, code}) do
        case code do
          0 ->
            info stdout
            {:ok, stdout}
          _ ->
            error stdout
            {:error, stdout}
        end
      end

      # FIXME same
      defp verify(input) do
        if input, do: {:ok, input}, else: {:error, "no file found"}
      end
    end
  end
end