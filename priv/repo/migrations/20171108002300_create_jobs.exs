defmodule Coderjobs.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :description, :text
      add :user_id, :integer
      add :location, :string
      add :is_external, :boolean, default: false, null: false
      add :url, :string

      timestamps()
    end

  end
end
