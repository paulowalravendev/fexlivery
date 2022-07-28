defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created",
               "user" => %{
                 "address" => "Rua test, 13",
                 "age" => 27,
                 "cpf" => "12345678901",
                 "email" => "test@mail.com",
                 "name" => "Name test"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{}

      expected = %{
        "message" => %{
          "age" => ["can't be blank"],
          "address" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"],
          "name" => ["can't be blank"],
          "password" => ["can't be blank"]
        }
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected
    end
  end

  describe "delete/2" do
    test "when there is an user with given id, deletes the user", %{conn: conn} do
      user = insert(:user)
      id = user.id

      conn
      |> delete(Routes.users_path(conn, :delete, id))
      |> response(:no_content)
    end

    test "when there is not an user with given id, returns an error", %{conn: conn} do
      id = Ecto.UUID.generate()
      expected = "{\"message\":\"User not found\"}"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:not_found)

      assert response == expected
    end
  end

  describe "show/2" do
    test "when there is an user with given id, show the user", %{conn: conn} do
      user = insert(:user)
      id = user.id

      expected =
        "{\"user\":{\"id\":\"58e597b9-56db-482a-9a68-17f6447f43f1\"," <>
          "\"age\":27,\"cpf\":\"12345678901\",\"address\":\"Rua test, 13\"," <>
          "\"email\":\"test@mail.com\",\"name\":\"Name test\"}}"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> response(:ok)

      assert response == expected
    end

    test "when there is not an user with given id, returns an error", %{conn: conn} do
      id = Ecto.UUID.generate()
      expected = "{\"message\":\"User not found\"}"

      response =
        conn
        |> get(Routes.users_path(conn, :delete, id))
        |> response(:not_found)

      assert response == expected
    end
  end
end
