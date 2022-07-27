defmodule Rockelivery.Users.Update do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo, User}

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_id_format_error()}
      {:ok, _id} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> do_update(user, params)
    end
  end

  defp do_update(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update!()
    |> handle_update()
  end

  defp handle_update(user), do: {:ok, user}

  defp handle_update({:error, _changeset}), do: Error.build_user_update_error()
end
