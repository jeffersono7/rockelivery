defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %Rockelivery.User{
               address: "Rua do Elixir",
               age: 27,
               cep: "89455979",
               cpf: "95495487980",
               email: "email-do-elixir@com",
               id: "86339c4e-b2a8-4aa7-954c-9f27ff23f1e1",
               inserted_at: nil,
               name: "Elixir",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } == response
  end
end
