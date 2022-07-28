defmodule Rockelivery.Items.Create do
  alias Rockelivery.{Error, Item, Repo}

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Item{} = result}), do: {:ok, %Item{} = result}

  defp handle_insert({:error, result}), do: {:error, Error.build_bad_request_error(result)}
end
