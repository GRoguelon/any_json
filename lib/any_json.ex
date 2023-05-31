defmodule AnyJson do
  @moduledoc """
  Documentation for `AnyJson`.
  """

  ## Behaviours

  @behaviour AnyJson.Codec

  ## Public functions

  @doc """
  Encodes any value into a valid JSON. Returns a tuple with `{:ok, json}` or `{:error, reason}`.
  """
  @impl true
  @spec encode(any(), keyword()) :: {:ok, String.t()} | {:error, any()}
  def encode(value, encode_opts \\ []), do: adapter().encode(value, encode_opts)

  @doc """
  Encodes any value into a valid JSON. Raises an exception if any errors happend.
  """
  @impl true
  @spec encode!(any(), keyword()) :: String.t()
  def encode!(value, encode_opts \\ []), do: adapter().encode!(value, encode_opts)

  @doc """
  Decodes a JSON value into an Elixir term. Returns a tuple with `{:ok, term}` or `{:error, reason}`.
  """
  @impl true
  @spec decode(String.t(), keyword()) :: {:ok, any()} | {:error, any()}
  def decode(value, decode_opts \\ []), do: adapter().decode(value, decode_opts)

  @doc """
  Decodes a JSON value into an Elixir term. Raises an exception if any errors happend.
  """
  @impl true
  @spec decode!(String.t(), keyword()) :: any()
  def decode!(value, decode_opts \\ []), do: adapter().decode!(value, decode_opts)

  # Defines the adapter function which can checked at compilation time.
  if Application.compile_env(:any_json, :compiled_adapter, false) do
    @adapter Application.compile_env(:any_json, :json_adapter)

    if is_nil(@adapter) do
      raise("Please set the `:json_adapter` configuration option in your `config.exs` file.")
    end

    @doc false
    @spec adapter() :: module()
    def adapter, do: @adapter
  else
    @doc false
    @spec adapter() :: module()
    def adapter, do: Application.get_env(:any_json, :json_adapter, AnyJson.Jason)
  end
end
