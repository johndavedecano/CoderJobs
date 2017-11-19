defmodule Coderjobs.Repo.Migrations.AddResetCodeUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :reset_code, :string
    end
  end
end
