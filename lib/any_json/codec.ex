defmodule AnyJson.Codec do
  @moduledoc """
  Defines the callbacks that the adapters must implement.
  """

  @doc """
  Encodes any value into a valid JSON. Returns a tuple with `{:ok, json}` or `{:error, reason}`.
  """
  @callback encode(term :: any(), encode_opts :: keyword()) :: {:ok, String.t()} | {:error, any()}

  @doc """
  Encodes any value into a valid JSON. Raises an exception if any errors happend.
  """
  @callback encode!(term :: any(), encode_opts :: keyword()) :: String.t()

  @doc """
  Decodes a JSON value into an Elixir term. Returns a tuple with `{:ok, term}` or `{:error, reason}`.
  """
  @callback decode(json :: String.t(), decode_opts :: keyword()) :: {:ok, any()} | {:error, any()}

  @doc """
  Decodes a JSON value into an Elixir term. Raises an exception if any errors happend.
  """
  @callback decode!(json :: String.t(), decode_opts :: keyword()) :: any()
end
