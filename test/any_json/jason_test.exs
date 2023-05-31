defmodule AnyJson.JasonTest do
  use ExUnit.Case, async: false

  alias AnyJson.Jason, as: Subject

  setup_all do
    on_exit(fn -> Application.put_env(:any_json, :json_adapter, AnyJsonMock) end)

    Application.put_env(:any_json, :json_adapter, Subject)

    {:ok,
     decoded_value: ["map", %{hello: 42}],
     encode_opts: [pretty: true],
     encoded_value: "[\"map\",{\"hello\":42}]",
     decode_opts: [keys: :atoms]}
  end

  describe "AnyJson.adapter/0" do
    test "returns AnyJson.Jason" do
      assert AnyJson.adapter() == Subject
    end
  end

  describe "callbacks" do
    test "encode returns same result as Jason", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode(value, opts) == Jason.encode(value, opts)
    end

    test "encode! returns same result as Jason", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode!(value, opts) == Jason.encode!(value, opts)
    end

    test "decode returns same result as Jason", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode(value, opts) == Jason.decode(value, opts)
    end

    test "decode! returns same result as Jason", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode!(value, opts) == Jason.decode!(value, opts)
    end
  end

  describe "callbacks with application options" do
    test "encode returns same result as Jason", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode(value) == Jason.encode(value, opts)
    end

    test "encode! returns same result as Jason", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode!(value) == Jason.encode!(value, opts)
    end

    test "decode returns same result as Jason", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode(value) == Jason.decode(value, opts)
    end

    test "decode! returns same result as Jason", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode!(value) == Jason.decode!(value, opts)
    end
  end
end
