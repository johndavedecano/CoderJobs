defmodule Coderjobs.Account.UserAuthActions do

  alias Coderjobs.Account.User
  
  alias Coderjobs.Repo
  alias Coderjobs.Email
  alias Coderjobs.Mailer
  alias Coderjobs.Randomizer

  def login(email, password) do
    user = Repo.get_by(User, email: email, is_verified: true)
    case user do
      nil ->
        {:error, "User not found."}
      user -> 
        check_password(user, password)
    end
  end

  defp check_password(user, password) do
    case Comeonin.Bcrypt.checkpw(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Invalid password."}
    end
  end

  def update_password(password, password_confirmation, _reset_code) when password == "" or password_confirmation == "" do
    {:error, "Password is required"}
  end

  def update_password(password, password_confirmation, _reset_code) when password != password_confirmation do
    {:error, "Password does not match"}
  end

  def update_password(password, _, reset_code) do
    case check_reset_code(reset_code) do
      {:error, reason} -> {:error, reason}
      {:ok, user} -> change_password(user, password)
    end
  end

  def change_password(user, password) do
    changeset = Ecto.Changeset.change user, password_hash: Comeonin.Bcrypt.hashpwsalt(password)
    changeset |> Repo.update
  end

  def forgot_password(email) do
    user = Repo.get_by(User, email: email)
    case user do
      nil ->
        {:error, "User not found"}
      user ->
        user
          |> update_reset_code
          |> Email.reset_email 
          |> Mailer.deliver_now
        {:ok, user}
    end
  end

  def update_reset_code(user) do
    reset_code = Randomizer.generate(20)
    changeset = Ecto.Changeset.change user, reset_code: reset_code
    case changeset |> Repo.update do
      {:ok, _} -> Repo.get_by(User, reset_code: reset_code) # We have to return an updated user
      {:error, _} -> {:error, "Unable to update user reset code for #{user.id}"}
    end
  end

  def check_reset_code(reset_code) do
    case Repo.get_by(User, reset_code: reset_code) do
      nil -> {:error, "Invalid password reset code."}
      user -> {:ok, user}
    end
  end

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
        {:error, "User not found."}
      user -> 
        verify_update(user)
        {:ok, user}
    end
  end

  defp verify_update(user) do
    changeset = Ecto.Changeset.change user, is_verified: true
    changeset |> Repo.update
  end
end
