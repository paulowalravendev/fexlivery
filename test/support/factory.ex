defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => "27",
      "address" => "Rua test, 13",
      "cep" => "12345678",
      "cpf" => "12345678901",
      "email" => "test@mail.com",
      "password" => "Test@123",
      "password_hash" => "",
      "name" => "Name test"
    }
  end

  def user_factory do
    %User{
      age: "27",
      address: "Rua test, 13",
      cep: "12345678",
      cpf: "12345678901",
      email: "test@mail.com",
      password: "Test@123",
      password_hash: "",
      name: "Name test",
      id: "58e597b9-56db-482a-9a68-17f6447f43f1"
    }
  end
end
