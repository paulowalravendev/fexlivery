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
  def build_id_format_error(), do: build(:bad_request, "Invalid id format")
  def build_bad_request_error(result), do: build(:bad_request, result)
  def build_user_update_error(), do: build(:bad_request, "Error on update user")
end
