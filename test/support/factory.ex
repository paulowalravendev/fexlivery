defmodule Rockelivery.Factory do
  use ExMachina

  def user_params_factory do
    %{
      age: "27",
      address: "Rua test, 13",
      cep: "12345678",
      cpf: "12345678901",
      email: "test@mail.com",
      password: "Test@123",
      password_hash: "",
      name: "Name test"
    }
  end
end
