defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.UUID
  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Delete, as: UserDelete

  import Rockelivery.Factory

  describe "call/1" do
    test "when uuid is valid and match an user, delete the user" do
      user = insert(:user)

      response = UserDelete.call(user.id)

      assert {:ok, %User{}} = response
    end

    test "when uuid is valid and dont match an user, returns an error" do
      response = UserDelete.call(UUID.generate())

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end
