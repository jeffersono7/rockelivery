defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID
  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when user not exists, returns an error not found" do
      actual =
        UUID.generate()
        |> Get.by_id()

      expected = {:error, Error.build_user_not_found_error()}

      assert actual == expected
    end

    test "when user exists, return it" do
      user = insert(:user)

      actual = Get.by_id(user.id)


      assert {:ok, %User{}} = actual
    end
  end
end
