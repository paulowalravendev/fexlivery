defmodule Rockelivery.ItemTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Item

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:item_params)

      response = Item.changeset(params)

      assert %Changeset{changes: %{description: "Pizza de calabresa"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{build(:item_params) | "price" => 0}

      expected = %{price: ["must be greater than 0"]}

      response = Item.changeset(params)

      assert errors_on(response) == expected
    end

    test "when all params are valid, update a changeset" do
      params = build(:item_params)

      update_params = %{"description" => "Pizza de calabresa com borda"}

      response =
        params
        |> Item.changeset()
        |> Changeset.apply_changes()
        |> Item.changeset(update_params)

      assert %Changeset{changes: %{description: "Pizza de calabresa com borda"}, valid?: true} =
               response
    end
  end
end
