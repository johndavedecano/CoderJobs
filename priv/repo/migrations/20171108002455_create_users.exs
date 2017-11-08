defmodule Coderjobs.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :mobile, :string
      add :email, :string
      add :company, :string
      add :company_logo, :string
      add :is_verified, :boolean, default: false, null: false

      timestamps()
    end

  end
end
