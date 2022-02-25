defmodule Rockelivery.ItemTest do
  use ExUnit.Case, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Item

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = params_for(:item)

      expected_price = Decimal.new("10.58")

      changeset = Item.changeset(params)

      assert %Changeset{
               changes: %{
                 category: :food,
                 description: "comida de teste",
                 photo: "/priv/photo1.jpg",
                 price: ^expected_price
               },
               errors: [],
               valid?: true
             } = changeset
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = params_for(:item, category: :not_food)

      expected_price = Decimal.new("10.58")

      changeset = Item.changeset(params)

      assert %Changeset{
               errors: [{:category, {"is invalid", _}}],
               valid?: false
             } = changeset
    end
  end
end
