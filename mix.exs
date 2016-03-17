defmodule ExrmDeploy.Mixfile do
  use Mix.Project

  def project do
    [app: :exrm_deploy,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [{:exrm, "~> 1.0.2"},
     {:bbmustache, ">= 0.0.0"},
     {:cf, ">= 0.0.0"},
     {:erlware_commons, ">= 0.0.0"},
     {:getopt, ">= 0.0.0"},
     {:providers, ">= 0.0.0"},
     {:relx, ">= 0.0.0"}]
  end

  defp aliases do
    []
  end
end
