defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        age: "27",
        address: "Rua test, 13",
        cep: "12345678",
        cpf: "12345678901",
        email: "test@mail.com",
        password: "Test@123",
        password_hash: "",
        name: "Name test"
      }

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Name test"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{
        age: 15,
        address: "Rua test, 13",
        cep: "12345678",
        cpf: "12345678901",
        email: "test@mail.com",
        password: "Tes",
        password_hash: "",
        name: "Name test"
      }

      expected = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      response = User.changeset(params)

      assert errors_on(response) == expected
    end
  end

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        age: "27",
        address: "Rua test, 13",
        cep: "12345678",
        cpf: "12345678901",
        email: "test@mail.com",
        password: "Test@123",
        password_hash: "",
        name: "Name test"
      }

      update_params = %{name: "Name test2"}

      response =
        params
        |> User.changeset()
        |> Changeset.apply_changes()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Name test2"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
    end
  end
end
