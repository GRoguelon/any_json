defmodule AnyJson.MixProject do
  use Mix.Project

  def project do
    [
      app: :any_json,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Docs
      name: "AnyJson",
      source_url: "https://github.com/GRoguelon/any_json",
      homepage_url: "https://hex.pm/packages/any_json",
      docs: [
        formatters: ["html"],
        main: "README",
        extras: ["README.md"],
        groups_for_modules: [
          Adapters: [AnyJson.Jason]
        ]
      ],
      # Dialyzer
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/project.plt"},
        plt_add_apps: [:jason]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    if Mix.env() == :test do
      [extra_applications: [:jason]]
    else
      []
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:jason, "~> 1.4", optional: true},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
