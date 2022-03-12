defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Item, Order, Repo}

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp fetch_items(%{"items" => items_param} = params) do
    item_ids = for item_param <- items_param, do: item_param["id"]

    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> validate_and_multiply_items(item_ids, params)
  end

  defp validate_and_multiply_items(items, items_ids, items_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    valid? = Enum.all?(items_ids, fn id -> Map.has_key?(items_map, id) end)

    multiply_items(valid?, items_map, items_params)
  end

  defp multiply_items(false, _items, _items_params), do: {:error, "Invalid ids!"}

  defp multiply_items(true, items, items_params) do
    items = Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
      item = Map.get(items, id)

      acc ++ List.duplicate(item, quantity)
    end)

    {:ok, items}
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{} = order}), do: order
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
