defmodule Rockelivery.Orders.Create do
  alias Rockelivery.{Error, Item, Order, Repo}
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  import Ecto.Query

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp fetch_items(%{"items" => items_param}) do
    item_ids = Enum.map(items_param, fn item -> item["id"] end)
    query = from item in Item, where: item.id in ^item_ids

    query
    |> Repo.all()
    |> ValidateAndMultiplyItems.call(item_ids, items_param)
  end

  defp handle_items({:error, result}, _params),
    do: {:error, Error.build_bad_request_error(result)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{} = order}), do: order
  defp handle_insert({:error, result}), do: {:error, Error.build_bad_request_error(result)}
end
