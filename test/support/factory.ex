defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.{Item, User}

  def user_params_factory do
    %{
      "age" => 27,
      "address" => "Rua do Elixir",
      "cep" => "89455979",
      "cpf" => "95495487980",
      "email" => "email-do-elixir@com",
      "password" => "123456",
      "name" => "Elixir"
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

  def item_factory do
    %Item{
      category: "food",
      description: "comida de teste",
      photo: "/priv/photo1.jpg",
      price: "10.58",
      id: "86339c4e-b2a8-4aa7-954c-9f27ff23f1e1"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
