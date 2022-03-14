defmodule Rockelivery.Orders.ValidateAndMultiplyItems do
  def call(items, items_ids, items_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    valid? = Enum.all?(items_ids, fn id -> Map.has_key?(items_map, id) end)

    multiply_items(valid?, items_map, items_params)
  end

  defp multiply_items(false, _items, _items_params), do: {:error, "Invalid ids!"}

  defp multiply_items(true, items, items_params) do
    items =
      Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(items, id)

        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end
end
