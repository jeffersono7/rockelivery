defmodule Rockelivery.Factory do
  use ExMachina

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
end
