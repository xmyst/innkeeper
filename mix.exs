defmodule Innkeeper.MixProject do
  use Mix.Project

  @source_url "https://github.com/xmyst/innkeeper"

  def project do
    [
      app: :innkeeper,
      name: "Innkeeper",
      version: "0.1.0",
      description: "Innkeeper creates and owns your ETS tables",
      source_url: @source_url,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      mod: {Innkeeper.Application, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.37", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      authors: ["Stas Miasnikoŭ <stas@miasnikou.name>"],
      extras: ["CHANGELOG.md", "README.md"],
      main: "readme",
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp package do
    [
      licenses: ["ISC"],
      links: %{"Source Code" => @source_url}
    ]
  end
end
