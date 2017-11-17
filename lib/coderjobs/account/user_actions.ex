defmodule Coderjobs.Account.UserActions do

  alias Coderjobs.Account.User
  alias Coderjobs.Repo
  alias Coderjobs.Email
  alias Coderjobs.Mailer

  def insert(user_params \\ %{}) do
    %User{}
      |> User.register_changeset(user_params)
      |> Repo.insert
  end
  
  def create(user_params \\ %{}) do
    case insert(user_params) do
      {:ok, user} ->
        Email.welcome_email(user) |> Mailer.deliver_now
        {:ok, user}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end
end
