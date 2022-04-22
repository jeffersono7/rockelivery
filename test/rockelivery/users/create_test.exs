defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory
  import Mox

  alias Rockelivery.ViaCep.ClientMock
  alias Rockelivery.{Error, User, Users}
  alias Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 27, email: "email-do-elixir@com"}} = response
    end

    test "when there are invalid params, return an error" do
      params = build(:user_params, %{"password" => "123", "age" => 15})

      response = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 19"],
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
