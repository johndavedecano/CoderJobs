defmodule Coderjobs.Job do
  use Ecto.Schema
  import Ecto.Changeset
  alias Coderjobs.Job


  schema "jobs" do
    field :description, :string
    field :is_external, :boolean, default: false
    field :is_remote, :boolean, default: false
    field :location, :string
    field :salary, :string
    field :skills, :string
    field :title, :string
    field :url, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Job{} = job, attrs) do
    job
    |> cast(attrs, [:title, :description, :user_id, :location, :is_external, :url])
    |> validate_required([:title, :description, :user_id, :location, :is_external, :url])
  end
end
