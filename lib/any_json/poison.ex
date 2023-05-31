if Application.compile_env(:any_json, :json_adapter) == AnyJson.Poison and
     not Code.ensure_loaded?(Poison) do
  raise "Missing dependencies for AnyJson.Poison. Please add `:poison` to your `mix.exs` file."
end

if Code.ensure_loaded?(Poison) do
  defmodule AnyJson.Poison do
    @moduledoc """
    Defines the implementation for the `Poison` adapter.

    ## Setup

    Add to your `mix.exs`:

        {:poison, "~> 5.0"},
    """

    ## Behaviours

    @behaviour AnyJson.Codec

    ## Typespecs

    @type encode_opts :: [Poison.Encoder.options()]

    @type decode_opts :: [Poison.Decoder.options()]

    @type encode_err :: Exception.t()

    @type decode_err :: Exception.t()

    ## Module attributes

    @encode_opts Application.compile_env(:any_json, [:poison_opts, :encode_opts], [])

    @decode_opts Application.compile_env(:any_json, [:poison_opts, :decode_opts], [])

    ## Public functions

    @impl true
    @spec encode(Poison.Encoder.t(), encode_opts()) :: {:ok, String.t()} | {:error, encode_err()}
    def encode(value, opts \\ []) do
      opts = @encode_opts ++ opts

      Poison.encode(value, opts)
    end

    @impl true
    @spec encode!(Poison.Encoder.t(), encode_opts()) :: String.t()
    def encode!(value, opts \\ []) do
      opts = @encode_opts ++ opts

      Poison.encode!(value, opts)
    end

    @impl true
    @spec decode(iodata(), decode_opts()) :: {:ok, any()} | {:error, decode_err()}
    def decode(value, opts \\ []) do
      opts = @decode_opts ++ opts

      Poison.decode(value, opts)
    end

    @impl true
    @spec decode!(iodata(), decode_opts()) :: any()
    def decode!(value, opts \\ []) do
      opts = @decode_opts ++ opts

      Poison.decode!(value, opts)
    end
  end
end
