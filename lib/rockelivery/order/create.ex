defmodule Rockelivery.Order.Create do
  alias Rockelivery.{Error, Item, Order, Repo}

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
    |> validate_and_multiply_items(item_ids, items_param)
  end

  defp validate_and_multiply_items(items, item_ids, items_param) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    item_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, items_param)
  end

  defp multiply_items(false, items, item_params) do
    items =
      Enum.reduce(item_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(items, id)
        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end

  defp multiply_items(true, _items, _item_params), do: {:error, "invaalid ids"}

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
