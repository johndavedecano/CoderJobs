defmodule Coderjobs.Repo.Migrations.AddCompanyFields do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :state, :string
      add :country, :string
      add :website, :string
      add :description, :text
      add :industry, :string
      add :company_size, :integer, default: 10
    end
  end
end
