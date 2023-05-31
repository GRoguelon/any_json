defmodule AnyJson.PoisonTest do
  use ExUnit.Case, async: false

  alias AnyJson.Poison, as: Subject

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
    test "returns AnyJson.Poison" do
      assert AnyJson.adapter() == Subject
    end
  end

  describe "callbacks" do
    test "encode returns same result as Poison", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode(value, opts) == Poison.encode(value, opts)
    end

    test "encode! returns same result as Poison", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode!(value, opts) == Poison.encode!(value, opts)
    end

    test "decode returns same result as Poison", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode(value, opts) == Poison.decode(value, opts)
    end

    test "decode! returns same result as Poison", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode!(value, opts) == Poison.decode!(value, opts)
    end
  end

  describe "callbacks with application options" do
    test "encode returns same result as Poison", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode(value) == Poison.encode(value, opts)
    end

    test "encode! returns same result as Poison", %{decoded_value: value, encode_opts: opts} do
      assert Subject.encode!(value) == Poison.encode!(value, opts)
    end

    test "decode returns same result as Poison", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode(value) == Poison.decode(value, opts)
    end

    test "decode! returns same result as Poison", %{encoded_value: value, decode_opts: opts} do
      assert Subject.decode!(value) == Poison.decode!(value, opts)
    end
  end
end
