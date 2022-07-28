defmodule Rockelivery.Items.UpdateTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.UUID
  alias Rockelivery.{Error, Item}
  alias Rockelivery.Items.Update, as: ItemUpdate

  import Rockelivery.Factory

  describe "call/1" do
    test "when id matchs a item with valid params, returns an updated item" do
      item = insert(:item)

      update_params = Map.put(%{build(:item_params) | "price" => 19.99}, "id", item.id)

      response = ItemUpdate.call(update_params)

      assert {:ok, %Item{price: %Decimal{coef: 1999}}} = response
    end

    test "when id matchs a item with invalid params, returns an error" do
      item = insert(:item)

      update_params = Map.put(%{build(:item_params) | "price" => 0}, "id", item.id)

      response = ItemUpdate.call(update_params)

      assert {:error, %Error{result: "Error on update item", status: :bad_request}} = response
    end

    test "when uuid is valid and dont match a item, returns an error" do
      update_params = Map.put(%{build(:item_params) | "price" => 19.99}, "id", UUID.generate())

      response = ItemUpdate.call(update_params)

      assert {:error, %Error{result: "Item not found", status: :not_found}} = response
    end
  end
end
