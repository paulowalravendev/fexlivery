defmodule RockeliveryWeb.ItemsViewTest do
  use RockeliveryWeb.ConnCase, async: true

  alias Rockelivery.Item
  alias RockeliveryWeb.ItemsView

  import Phoenix.View
  import Rockelivery.Factory

  test "renders create.json" do
    item = build(:item)

    response = render(ItemsView, "create.json", item: item)

    assert %{
             message: "Item created",
             item: %Item{
               category: "food",
               description: "Pizza de calabresa",
               price: "32.99",
               photo:
                 "https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg",
               id: "63f8dcf1-e63f-4c8f-9619-16e2be50fbac"
             }
           } = response
  end

  test "renders item.json" do
    item = build(:item)

    response = render(ItemsView, "item.json", item: item)

    assert %{
             item: %Item{
               category: "food",
               description: "Pizza de calabresa",
               price: "32.99",
               photo:
                 "https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg",
               id: "63f8dcf1-e63f-4c8f-9619-16e2be50fbac"
             }
           } = response
  end
end
