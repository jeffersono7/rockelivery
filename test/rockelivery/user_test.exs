defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        age: 27,
        address: "Rua das macas",
        cep: "12345678",
        cpf: "12378912320",
        email: "email@com",
        password: "123456",
        name: "Name"
      }

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Name"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = %{
        age: 27,
        address: "Rua das macas",
        cep: "12345678",
        cpf: "12378912320",
        email: "email@com",
        password: "123456",
        name: "Name"
      }

      update_params = %{
        name: "Bananinha",
        password: "123456"
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Bananinha"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{
        age: 15,
        address: "Rua das macas",
        cep: "12345678",
        cpf: "12378912320",
        email: "email@com",
        password: "123",
        name: "Name"
      }

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
