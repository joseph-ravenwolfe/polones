# :1234: Polones

Polones is a reverse polish calculator written in Elixir.

## Features

### Highly Maintainable

Requirements change? No problem, Polones is highly extensible. Need a new interface? We have you covered. Don't like RPN? Swap out the Calculator. Everything in Polones is built for long running evolution.

Polones comes pre-built with an Elixir string and Console adapter, but you can easily create your own as the project's needs change.

```elixir
# Create a Console adapter that uses Emoji prompts.
defmodule Polones.MyEmojiAdapter do
  # ...
end
```

### Time Machine

![Delorean](https://media.giphy.com/media/xsF1FSDbjguis/giphy.gif)

Make a mistake? Don't panic, just rewind and fast forward through time with `rw`, and `ff`. You'll feel like a master of the universe.

```shell
> 2 30 +
32.0 # Whoops
> rw
30.0
> rw
2.0
> 0.3 +
2.3
> q
Bye!
```

## Usage

For machines with Elixir, run `mix calculator`.

In Progress: This package will also be vendored via Docker and as a runnable
binary, but this is currently still under active development.

Or in Elixir:

```elixir
Polones.start_session
> 2 3 +
# => 5.0
> 2
# => 2.0
> *
# => 10.0