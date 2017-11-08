defmodule Coderjobs.Repo.Migrations.AddReferenceJobs do
  use Ecto.Migration

  def change do
    alter table(:jobs) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
