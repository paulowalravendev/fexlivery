defmodule Rockelivery.Items.DeleteTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.UUID
  alias Rockelivery.{Error, Item}
  alias Rockelivery.Items.Delete, as: ItemDelete

  import Rockelivery.Factory

  describe "call/1" do
    test "when uuid is valid and match an item, delete the item" do
      item = insert(:item)

      response = ItemDelete.call(item.id)

      assert {:ok, %Item{}} = response
    end

    test "when uuid is valid and dont match an item, returns an error" do
      response = ItemDelete.call(UUID.generate())

      assert {:error, %Error{result: "Item not found", status: :not_found}} = response
    end
  end
end
