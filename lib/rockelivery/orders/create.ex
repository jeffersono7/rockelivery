defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  def call(%{"items" => items_params} = params) do
    item_ids = for item_param <- items_params, do: item_param["id"]

    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(item_ids, items_params)
    |> handle_items(params)
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{} = order}), do: {:ok, order}
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
