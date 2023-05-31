if Application.compile_env(:any_json, :json_adapter) == AnyJson.Jason and
     not Code.ensure_loaded?(Jason) do
  raise "Missing dependencies for AnyJson.Jason. Please add `:jason` to your `mix.exs` file."
end

if Code.ensure_loaded?(Jason) do
  defmodule AnyJson.Jason do
    @moduledoc """
    Defines the implementation for the `Jason` adapter.

    ## Setup

    Add to your `mix.exs`:

        {:jason, "~> 1.4"},
    """

    ## Behaviours

    @behaviour AnyJson.Codec

    ## Typespecs

    @type encode_opts :: [Jason.encode_opt()]

    @type decode_opts :: [Jason.decode_opt()]

    @type encode_err :: Jason.EncodeError.t() | Exception.t()

    @type decode_err :: Jason.DecodeError.t()

    ## Module attributes

    @encode_opts Application.compile_env(:any_json, [:jason_opts, :encode_opts], [])

    @decode_opts Application.compile_env(:any_json, [:jason_opts, :decode_opts], [])

    ## Public functions

    @impl true
    @spec encode(any(), encode_opts()) :: {:ok, String.t()} | {:error, encode_err()}
    def encode(value, opts \\ []) do
      opts = @encode_opts ++ opts

      Jason.encode(value, opts)
    end

    @impl true
    @spec encode!(term(), encode_opts()) :: String.t()
    def encode!(value, opts \\ []) do
      opts = @encode_opts ++ opts

      Jason.encode!(value, opts)
    end

    @impl true
    @spec decode(iodata(), decode_opts()) :: {:ok, any()} | {:error, decode_err()}
    def decode(value, opts \\ []) do
      opts = @decode_opts ++ opts

      Jason.decode(value, opts)
    end

    @impl true
    @spec decode!(iodata(), decode_opts()) :: any()
    def decode!(value, opts \\ []) do
      opts = @decode_opts ++ opts

      Jason.decode!(value, opts)
    end
  end
end
