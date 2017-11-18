defmodule Coderjobs.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Coderjobs.Account.User
  alias Coderjobs.Randomizer

  schema "users" do
    field :email, :string, unique: true
    field :company, :string
    field :company_logo, :string
    field :is_verified, :boolean, default: false
    field :mobile, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :username, :string, unique: true
    field :verification_code, :string
    timestamps()
  end

  @doc false
  def register_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :email, :password, :password_confirmation, :verification_code])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_required([:name, :username, :email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:username, min: 3, max: 25)
    |> validate_confirmation(:password)
    |> put_password_hash
    |> put_verification_code
  end

  defp put_verification_code(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :verification_code, Randomizer.generate(20))
      _ ->
        changeset
    end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
