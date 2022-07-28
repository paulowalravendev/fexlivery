defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Name test"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{build(:user_params) | age: 17, password: "123"}

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
      params = build(:user_params)

      update_params = %{name: "Name test2"}

      response =
        params
        |> User.changeset()
        |> Changeset.apply_changes()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Name test2"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:user_params)
      update_params = %{name: ""}
      expected = %{name: ["can't be blank"]}

      response =
        params
        |> User.changeset()
        |> Changeset.apply_changes()
        |> User.changeset(update_params)

      assert errors_on(response) == expected
    end
  end
end
