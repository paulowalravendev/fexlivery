defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.{Item, User}

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

  def item_params_factory do
    %{
      "category" => "food",
      "description" => "Pizza de calabresa",
      "price" => 32.99,
      "photo" =>
        "https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg"
    }
  end

  def item_factory do
    %Item{
      category: "food",
      description: "Pizza de calabresa",
      price: "32.99",
      photo:
        "https://www.comidaereceitas.com.br/wp-content/uploads/2015/07/pizza-calabresa-especial.jpg",
      id: "63f8dcf1-e63f-4c8f-9619-16e2be50fbac"
    }
  end
end
