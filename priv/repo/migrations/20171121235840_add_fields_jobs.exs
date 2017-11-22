defmodule Coderjobs.Repo.Migrations.AddFieldsJobs do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :skills, :string
      add :salary, :string
      add :is_remote, :boolean, default: false, null: false
    end
  end
end
