defmodule Coderjobs.Repo.Migrations.AddVerificationUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :verification_code, :string
      add :verification_created_at, :naive_datetime
    end
  end
end
