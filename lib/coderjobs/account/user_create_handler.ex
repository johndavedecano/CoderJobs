defmodule Coderjobs.Account.UserCreateHandler do

  alias Coderjobs.Account.User
  alias Coderjobs.Repo

  defp insert(user_params \\ %{}) do
    %User{}
      |> User.register_changeset(user_params)
      |> Repo.insert
  end

  def create(user_params \\ %{}) do
    case insert(user_params) do
      {:ok, user} ->
        {:ok, user}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end
end
