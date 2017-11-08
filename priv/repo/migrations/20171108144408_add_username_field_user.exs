defmodule Coderjobs.Repo.Migrations.AddUsernameFieldUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
    end
    create unique_index(:users, [:email, :username])
  end
end
