defmodule Rockelivery.Orders.Create do

  import Ecto.Query

  alias Rockelivery.{Item, Order, Repo}

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => items_param} = params) do
    item_ids = for item_param <- items_param, do: item_param["id"]

    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> validate_items(item_ids)
  end

  defp validate_items(items, items_ids) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    Enum.all?(items_ids, fn id -> Map.has_key?(items_map, id) end)
  end
end
