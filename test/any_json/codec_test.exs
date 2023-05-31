defmodule AnyJson.CodecTest do
  use ExUnit.Case, async: true

  alias AnyJson.Codec, as: Subject

  describe "callbacks" do
    test "requires encode!/2" do
      assert {:encode!, 2} in Subject.behaviour_info(:callbacks)
    end

    test "requires encode/2" do
      assert {:encode, 2} in Subject.behaviour_info(:callbacks)
    end

    test "requires decode!/2" do
      assert {:decode!, 2} in Subject.behaviour_info(:callbacks)
    end

    test "requires decode/2" do
      assert {:decode, 2} in Subject.behaviour_info(:callbacks)
    end
  end
end
