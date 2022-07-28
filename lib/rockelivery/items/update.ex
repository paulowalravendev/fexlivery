defmodule Rockelivery.Items.Update do
  alias Rockelivery.{Error, Item, Repo}

  def call(%{"id" => id} = params) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build_item_not_found_error()}
      item -> do_update(item, params)
    end
  end

  defp do_update(%Item{} = item, params) do
    changeset = Item.changeset(item, params)

    if changeset.valid? do
      Repo.update(changeset)
    else
      {:error, Error.build_item_update_error()}
    end
  end
end
