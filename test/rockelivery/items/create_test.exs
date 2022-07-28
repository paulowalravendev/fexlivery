defmodule Rockelivery.Items.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, Item}
  alias Rockelivery.Items.Create, as: ItemCreate

  import Rockelivery.Factory

  describe "call/1" do
    test "when all params are valid, returns a new item" do
      params = build(:item_params)

      response = ItemCreate.call(params)

      assert {:ok, %Item{description: "Pizza de calabresa"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{build(:item_params) | "price" => 0}

      expected_changeset_errors = %{price: ["must be greater than 0"]}

      response = ItemCreate.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_changeset_errors
    end
  end
end
