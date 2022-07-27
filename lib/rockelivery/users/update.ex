defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> do_update(user, params)
    end
  end

  defp do_update(%User{} = user, params) do
    changeset = User.changeset(user, params)

    if changeset.valid? do
      Repo.update!(changeset)
      {:ok, user}
    else
      {:error, Error.build_user_update_error()}
    end
  end
end
