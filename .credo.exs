%{
  configs: [
    %{
      name: "default",
      strict: true,
      files: %{
        included:
          ".formatter.exs"
          |> Code.eval_file()
          |> elem(0)
          |> Keyword.get(:inputs)
      },
      checks: %{
        disabled: [
          {Credo.Check.Readability.ParenthesesOnZeroArityDefs, false}
        ]
      }
    }
  ]
}
