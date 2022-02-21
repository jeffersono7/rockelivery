defmodule RockeliveryWeb.UsersControllerWeb do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Ecto.UUID
  alias Rockelivery.User

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create), params)
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua do Elixir",
                 "age" => 27,
                 "cpf" => "95495487980",
                 "email" => "email-do-elixir@com",
                 "id" => _id
               }
             } = response
    end

    test "when there are some error, returns the error", %{conn: conn} do
      params = %{password: "123456", name: "jefferson"}

      response =
        conn
        |> post(Routes.users_path(conn, :create), params)
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end

  describe "show/2" do
    test "when there is a user with the given id, returns it", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      expected = %{
        "user" => %{
          "address" => "Rua do Elixir",
          "age" => 27,
          "cpf" => "95495487980",
          "email" => "email-do-elixir@com",
          "id" => "86339c4e-b2a8-4aa7-954c-9f27ff23f1e1"
        }
      }

      assert response == expected
    end

    test "when there is not user with the given id, returns not found error", %{conn: conn} do
      id = UUID.generate()

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => _} = response
    end
  end

  describe "update/2" do
    test "given there is a user, when update it with other params, return it updated", %{
      conn: conn
    } do
      user = insert(:user)

      params = %{age: 55}

      response =
        conn
        |> put(Routes.users_path(conn, :update, user.id), params)
        |> json_response(:ok)

      assert %{"user" => %{"age" => 55}} = response
    end
  end
end
