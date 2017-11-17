defmodule Coderjobs.Repo.Migrations.RemoveVerificationDate do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :verification_created_at
    end
  end
end
