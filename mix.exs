defmodule LetrollBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :letroll_bot,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex, :cachex],
      mod: {LeTrollSupervisor, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nostrum, git: "https://github.com/Kraigie/nostrum.git"},
      {:nba, "~> 0.4.0"},
      {:httpoison, "~> 1.4", override: true},
      {:poison, "~> 4.0", override: true},
      {:timex, "~> 3.1"},
      {:cachex, "~> 3.1"},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end
end
