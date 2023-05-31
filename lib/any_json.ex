defmodule AnyJson do
  @moduledoc """
  Documentation for `AnyJson`.
  """

  ## Behaviours

  @behaviour AnyJson.Codec

  ## Public functions

  @impl true
  @spec encode(any(), keyword()) :: {:ok, String.t()} | {:error, any()}
  def encode(value, opts \\ []), do: adapter().encode(value, opts)

  @impl true
  @spec encode!(any(), keyword()) :: String.t()
  def encode!(value, opts \\ []), do: adapter().encode!(value, opts)

  @impl true
  @spec decode(String.t(), keyword()) :: {:ok, any()} | {:error, any()}
  def decode(value, opts \\ []), do: adapter().decode(value, opts)

  @impl true
  @spec decode!(String.t(), keyword()) :: any()
  def decode!(value, opts \\ []), do: adapter().decode!(value, opts)

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
