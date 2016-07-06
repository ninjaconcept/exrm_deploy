defmodule Mix.Tasks.ExrmDeploy.Deploy do
  use Mix.Task
  use ExrmDeploy.Mixin

  def run(args) do
    case args do
      [] -> deploy
      _  -> Mix.Task.run "exrm_deploy.launcher", args
    end
  end

  defp deploy do
    info "Running build tasks"
    Enum.map(["deps.get", "deps.compile", "compile", "phoenix.digest"], fn (task) -> 
      Mix.Task.run task, []
    end)
    
    Mix.Task.run "release", ["--no-confirm-missing"]

    info "deploying #{app} ( #{config[:server]} )"
    Path.wildcard("rel/#{app}/releases/*.*.*/*.tar.gz")
    |> List.last
    |> verify
    |> copy
    |> unpack
    |> activate
    |> message
  end

  defp message({:ok, _}),      do: info("All Done!")
  defp message({:error, msg}), do: error("Failed, reason: #{msg}")
end
