defmodule Rockelivery.Users.Delete do
  alias Rockelivery.{Error, Repo, User}

  @spec call(binary()) :: {:error, Error} | {:ok, User}
  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> Repo.delete(user)
    end
  end
end
