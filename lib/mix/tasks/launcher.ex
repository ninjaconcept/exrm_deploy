defmodule Mix.Tasks.ExrmDeploy.Launcher do
  use Mix.Task
  use ExrmDeploy.Mixin

  def run(args) do
    case List.first(args) do
      "log"     -> sshexec("tail -n 100 #{app}/log/*")

      "start"   -> appexec(:start)
      "stop"    -> appexec(:stop)
      "restart" -> appexec(:restart)
      "ping"    -> appexec(:ping)
      
      "migrate" -> appexec("escript bin/release_tasks.escript migrate")
      "seed"    -> appexec("escript bin/release_tasks.escript seed")
      
      "reset"   -> info("not implemented yet")
      
      "--help"  -> info """
== Exrm Deployment ==

Deployment is done using SSH, so make sure you 
can connect to the server first :)

see (config/#\{Mix.env\}.exs)

  $ mix deploy            # deployment (includes upgrade)
  $ mix deploy log        # view server logs
  $ mix deploy start      # start, stop, restart -> application
  $ mix deploy ping       # application running?

  $ mix deploy migrate    # call DB migration
  $ mix deploy seed       # call DB seeds
  $ mix deploy reset      # reset DB

"""
      rest      -> info("command not found: #{rest}\n\ntry: $ mix deploy --help")
    end
  end
end
