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
        Email.welcome_email(user) |> Mailer.deliver_now # or deliver_later
        {:ok, user}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}
    end
  end

  def verify(code) do
    case Repo.get_by(User, verification_code: code) do
      nil ->
        {:error, "Unable to verify account."}
      user -> 
        verify_update(user)
        {:ok, user}
    end
  end

  defp verify_update(user) do
    Ecto.Changeset.change user, is_verified: true |> Repo.update
  end
end
