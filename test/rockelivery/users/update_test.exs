defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.UUID
  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Update, as: UserUpdate

  import Rockelivery.Factory

  describe "call/1" do
    test "when id matchs a user with valid params, returns an updated user" do
      user = insert(:user)

      update_params = Map.put(%{build(:user_params) | "age" => 30}, "id", user.id)

      response = UserUpdate.call(update_params)

      assert {:ok, %User{age: 30}} = response
    end

    test "when id matchs a user with invalid params, returns an error" do
      user = insert(:user)

      update_params = Map.put(%{build(:user_params) | "age" => 17}, "id", user.id)

      response = UserUpdate.call(update_params)

      assert {:error, %Error{result: "Error on update user", status: :bad_request}} = response
    end

    test "when uuid is valid and dont match a user, returns an error" do
      update_params = Map.put(%{build(:user_params) | "age" => 30}, "id", UUID.generate())

      response = UserUpdate.call(update_params)

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end
