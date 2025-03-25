ExUnit.start()

defmodule TestHelper do
  defmacro compiler_options(options, do: block) do
    quote do
      orig_compiler_options = Code.compiler_options()
      Code.compiler_options(unquote(options))
      unquote(block)
      Code.compiler_options(orig_compiler_options)
    end
  end
end
