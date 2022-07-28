defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.UUID
  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.Get, as: UserGet

  import Rockelivery.Factory

  describe "by_id/1" do
    test "when uuid is valid and match a user, returns an user" do
      user = insert(:user)
      response = UserGet.by_id(user.id)

      assert {:ok, %User{}} = response
    end

    test "when uuid is valid and dont match a user, returns an error" do
      response = UserGet.by_id(UUID.generate())

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end
