defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{} = result}), do: {:ok, %User{} = result}

  defp handle_insert({:error, result}), do: {:error, Error.build_bad_request_error(result)}
end
