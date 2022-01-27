defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{Error, User, Repo}
  alias Rockelivery.Users.Get

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> Repo.delete(user)
    end
  end
end
