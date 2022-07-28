defmodule Rockelivery.Items.GetTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.UUID
  alias Rockelivery.{Error, Item}
  alias Rockelivery.Items.Get, as: ItemGet

  import Rockelivery.Factory

  describe "by_id/1" do
    test "when uuid is valid and match a item, returns an item" do
      item = insert(:item)
      response = ItemGet.by_id(item.id)

      assert {:ok, %Item{}} = response
    end

    test "when uuid is valid and dont match a item, returns an error" do
      response = ItemGet.by_id(UUID.generate())

      assert {:error, %Error{result: "Item not found", status: :not_found}} = response
    end
  end
end
