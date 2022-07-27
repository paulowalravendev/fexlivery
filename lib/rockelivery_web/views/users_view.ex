defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User

  def render("create.json", %{user: %User{} = user}),
    do: %{
      message: "User created",
      user: user
    }

  def render("show.json", %{user: %User{} = user}), do: %{user: user}
end
