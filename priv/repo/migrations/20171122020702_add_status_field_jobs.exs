defmodule Coderjobs.Repo.Migrations.AddStatusFieldJobs do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      add :status, :string, default: "active"
    end
  end
end
