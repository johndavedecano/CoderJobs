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
    
    field :password_current, :string, virtual: true
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    field :username, :string, unique: true
    field :verification_code, :string
    field :reset_code, :string
    has_many :jobs, Coderjobs.Posts.Job
    timestamps()
  end

  def password_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:password, :password_confirmation, :password_current])
    |> validate_required([:password, :password_current, :password_confirmation])
    |> validate_length(:password, min: 6, max: 25)
    |> validate_confirmation(:password)
    |> validate_password(user)
    |> put_password_hash
  end

  defp validate_password(changeset, user) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: _}} ->
        case Comeonin.Bcrypt.checkpw(get_field(changeset, :password_current), user.password_hash) do
          true -> changeset
          false -> add_error(changeset, :password_current, "is invalid")
        end
      _ ->
        changeset
    end
  end

  def account_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :mobile, :company, :company_logo])
    |> unique_constraint(:username)
    |> validate_required([:name, :username, :mobile, :company])
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
