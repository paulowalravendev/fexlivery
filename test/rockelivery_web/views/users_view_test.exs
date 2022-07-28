defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  alias Rockelivery.User
  alias RockeliveryWeb.UsersView

  import Phoenix.View
  import Rockelivery.Factory

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created",
             user: %User{
               address: "Rua test, 13",
               age: "27",
               cep: "12345678",
               cpf: "12345678901",
               email: "test@mail.com",
               id: "58e597b9-56db-482a-9a68-17f6447f43f1",
               inserted_at: nil,
               name: "Name test",
               password: "Test@123",
               password_hash: "",
               updated_at: nil
             }
           } = response
  end

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %User{
               address: "Rua test, 13",
               age: "27",
               cep: "12345678",
               cpf: "12345678901",
               email: "test@mail.com",
               id: "58e597b9-56db-482a-9a68-17f6447f43f1",
               inserted_at: nil,
               name: "Name test",
               password: "Test@123",
               password_hash: "",
               updated_at: nil
             }
           } = response
  end
end
