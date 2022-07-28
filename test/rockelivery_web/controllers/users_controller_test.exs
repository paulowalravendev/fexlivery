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
end
