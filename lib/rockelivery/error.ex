defmodule Rockelivery.Error do
  @keys [:status, :result]

  @enforce_keys @keys

  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end

  def build_user_not_found_error(), do: build(:not_found, "User not found")
  def build_item_not_found_error(), do: build(:not_found, "Item not found")
  def build_bad_request_error(result), do: build(:bad_request, result)
  def build_user_update_error(), do: build(:bad_request, "Error on update user")
  def build_item_update_error(), do: build(:bad_request, "Error on update item")
end
