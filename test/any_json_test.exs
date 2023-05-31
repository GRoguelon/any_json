defmodule AnyJsonTest do
  use ExUnit.Case, async: true

  import Mox, only: [expect: 3, verify_on_exit!: 1]

  alias AnyJson, as: Subject

  describe "adapter/0" do
    test "returns AnyJsonMock" do
      assert Subject.adapter() == AnyJsonMock
    end
  end

  describe "with mocked adapter" do
    setup :verify_on_exit!

    test "encode/2 calls the adapter" do
      expect(AnyJsonMock, :encode, fn %{hello: 42}, [custom: :option] -> {:ok, "encoded"} end)

      assert Subject.encode(%{hello: 42}, custom: :option) == {:ok, "encoded"}
    end

    test "encode!/2 calls the adapter" do
      expect(AnyJsonMock, :encode!, fn %{hello: 42}, [custom: :option] -> "encoded" end)

      assert Subject.encode!(%{hello: 42}, custom: :option) == "encoded"
    end

    test "decode/2 calls the adapter" do
      expect(AnyJsonMock, :decode, fn %{hello: 42}, [custom: :option] -> {:ok, "decoded"} end)

      assert Subject.decode(%{hello: 42}, custom: :option) == {:ok, "decoded"}
    end

    test "decode!/2 calls the adapter" do
      expect(AnyJsonMock, :decode!, fn %{hello: 42}, [custom: :option] -> "decoded" end)

      assert Subject.decode!(%{hello: 42}, custom: :option) == "decoded"
    end
  end
end
