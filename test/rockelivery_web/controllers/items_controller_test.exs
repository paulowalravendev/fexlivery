defmodule RockeliveryWeb.ItemsControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the item", %{conn: conn} do
      params = build(:item_params)

      response =
        conn
        |> post(Routes.items_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "item" => %{
                 "category" => "food",
                 "description" => "Pizza de calabresa",
                 "photo" =>
                   "https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg",
                 "price" => "32.99"
               },
               "message" => "Item created"
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{}

      expected = %{
        "message" => %{
          "category" => ["can't be blank"],
          "description" => ["can't be blank"],
          "photo" => ["can't be blank"],
          "price" => ["can't be blank"]
        }
      }

      response =
        conn
        |> post(Routes.items_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected
    end
  end

  describe "delete/2" do
    test "when there is an item with given id, deletes the item", %{conn: conn} do
      item = insert(:item)
      id = item.id

      conn
      |> delete(Routes.items_path(conn, :delete, id))
      |> response(:no_content)
    end

    test "when there is not an item with given id, returns an error", %{conn: conn} do
      id = Ecto.UUID.generate()
      expected = "{\"message\":\"Item not found\"}"

      response =
        conn
        |> delete(Routes.items_path(conn, :delete, id))
        |> response(:not_found)

      assert response == expected
    end
  end

  describe "show/2" do
    test "when there is an item with given id, show the item", %{conn: conn} do
      item = insert(:item)
      id = item.id

      expected =
        "{\"item\":{\"category\":\"food\",\"description\":\"Pizza de calabresa\"" <>
          ",\"price\":\"32.99\",\"photo\":\"https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg\"," <>
          "\"id\":\"63f8dcf1-e63f-4c8f-9619-16e2be50fbac\"}}"

      response =
        conn
        |> get(Routes.items_path(conn, :show, id))
        |> response(:ok)

      assert response == expected
    end

    test "when there is not an item with given id, returns an error", %{conn: conn} do
      id = Ecto.UUID.generate()
      expected = "{\"message\":\"Item not found\"}"

      response =
        conn
        |> get(Routes.items_path(conn, :delete, id))
        |> response(:not_found)

      assert response == expected
    end
  end

  describe "update/2" do
    test "when there is an item with given id and valid params, update the item", %{conn: conn} do
      item = insert(:item)
      id = item.id
      update_param = %{"name" => "Name test1"}

      expected =
        "{\"item\":{\"category\":\"food\",\"description\":\"Pizza de calabresa\"," <>
          "\"price\":\"32.99\",\"photo\":\"https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg\"," <>
          "\"id\":\"63f8dcf1-e63f-4c8f-9619-16e2be50fbac\"}}"

      response =
        conn
        |> put(Routes.items_path(conn, :update, id, update_param))
        |> response(:ok)

      assert response == expected
    end

    test "when there is an item with given id and invalid params, returns an error", %{conn: conn} do
      item = insert(:item)
      id = item.id
      update_param = %{"description" => ""}

      expected = "{\"message\":\"Error on update item\"}"

      response =
        conn
        |> put(Routes.items_path(conn, :update, id, update_param))
        |> response(:bad_request)

      assert response == expected
    end

    test "when there is not an item with given id, returns an error", %{conn: conn} do
      id = Ecto.UUID.generate()
      expected = "{\"message\":\"Item not found\"}"
      update_param = %{"name" => "Name test1"}

      response =
        conn
        |> put(Routes.items_path(conn, :update, id, update_param))
        |> response(:not_found)

      assert response == expected
    end
  end
end
