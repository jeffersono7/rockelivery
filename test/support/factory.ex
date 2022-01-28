defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 27,
      address: "Rua do Elixir",
      cep: "89455979",
      cpf: "95495487980",
      email: "email-do-elixir@com",
      password: "123456",
      name: "Elixir"
    }
  end

  def user_factory do
    %User{
      age: 27,
      address: "Rua do Elixir",
      cep: "89455979",
      cpf: "95495487980",
      email: "email-do-elixir@com",
      password: "123456",
      name: "Elixir",
      id: "86339c4e-b2a8-4aa7-954c-9f27ff23f1e1"
    }
  end
end
