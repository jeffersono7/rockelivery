defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID
  alias Rockelivery.Error
  alias Rockelivery.Users.Delete

  describe "call/1" do
    test "when user not exists, returns an error not found" do
      actual =
        UUID.generate()
        |> Delete.call()

      expected = {:error, Error.build_user_not_found_error()}

      assert actual == expected
    end

    test "when user exists, delete and return it" do
      user = build(:user)

      actual = Delete.call(user.id)

      expected = {:ok, user}

      assert actual = expected

      assert {:error, Error.build_user_not_found_error()} == Delete.call(user.id)
    end
  end
end
