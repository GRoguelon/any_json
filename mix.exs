defmodule AnyJson.MixProject do
  use Mix.Project

  def project do
    [
      app: :any_json,
      version: "0.2.0-rc.0",
      elixir: "~> 1.12",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "AnyJson",
      description: "Elixir library to wrap the main JSON libraries",
      source_url: "https://github.com/GRoguelon/any_json",
      docs: docs(),
      dialyzer: dialyzer()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    if Mix.env() == :test do
      [extra_applications: [:jason, :poison]]
    else
      []
    end
  end

  defp docs do
    [
      formatters: ["html"],
      main: "README",
      extras: ["README.md"],
      groups_for_modules: [
        Adapters: [AnyJson.Jason, AnyJson.Poison]
      ]
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/project.plt"},
      plt_add_apps: [:jason, :poison]
    ]
  end

  defp package do
    [
      # These are the default files included in the package
      files: ~w[lib mix.exs README* LICENSE*],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/GRoguelon/any_json"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:jason, "~> 1.4", optional: true},
      {:mox, "~> 1.0", only: :test},
      {:poison, "~> 5.0", optional: true}
    ]
  end
end
