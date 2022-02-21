defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID
  alias Rockelivery.{Error, User, Users}
  alias Users.Update

  describe "call/1" do
    test "when users not exists, return an error" do
      id = UUID.generate()

      actual = Update.call(%{"id" => id})

      expected = {:error, Error.build_user_not_found_error()}

      assert actual == expected
    end

    test "when users exists, update it" do
      user = insert(:user)
      user_id = user.id

      actual = Update.call(%{"id" => user_id, "name" => "tester"})

      assert {:ok, %User{id: ^user_id, name: "tester"}} = actual
    end
  end
end
