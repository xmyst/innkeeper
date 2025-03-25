# Innkeeper

* Innkeeper creates and owns your ETS tables.
* Innkeeper makes them public and named.
* Innkeeper does not do anything else.

## Installation

Innkeeper wants Elixir v1.18, but is willing to bargain. Venture forth, add
Innkeeper to the dependencies:

```elixir
def deps do
  [
    {:innkeeper, "~> 0.1.0"},
  ]
end
```

Run `mix deps.get` and see what happens.

## Usage

Once you need an ETS table:

```elixir
use Innkeeper

ets_table :my_table, read_concurrency: true, write_concurrency: :auto
```

The table will be provided.
