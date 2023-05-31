defmodule AnyJson.Codec do
  @moduledoc """
  Defines the callbacks that the adapters must implement.
  """

  @callback encode(any(), keyword()) :: {:ok, String.t()} | {:error, any()}

  @callback encode!(any(), keyword()) :: String.t()

  @callback decode(String.t(), keyword()) :: {:ok, any()} | {:error, any()}

  @callback decode!(String.t(), keyword()) :: any()
end
