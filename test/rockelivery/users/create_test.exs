defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Create, as: UserCreate

  import Rockelivery.Factory

  describe "call/1" do
    test "when all params are valid, returns a new user" do
      params = build(:user_params)

      response = UserCreate.call(params)

      assert {:ok, %User{name: "Name test"}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{build(:user_params) | "age" => 17, "password" => "123"}

      expected_changeset_errors = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      response = UserCreate.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_changeset_errors
    end
  end
end
