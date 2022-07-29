defmodule Rockelivery.Orders.ValidateAndMultiplyItems do
  def call(items, item_ids, items_param) do
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
end
