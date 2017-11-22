defmodule Coderjobs.Job do
  use Ecto.Schema
  import Ecto.Changeset
  alias Coderjobs.Job


  schema "jobs" do
    field :description, :string
    field :is_external, :boolean, default: false
    field :is_remote, :boolean, default: false
    field :location, :string
    field :salary, :string, default: "Not Specified"
    field :skills, :string
    field :title, :string
    field :url, :string
    field :user_id, :integer
    timestamps()
  end

  @doc false
  def changeset(%Job{} = job, attrs) do
    job
    |> cast(attrs, [:description, :is_external, :is_remote, :location, :salary, :skills, :title, :url])
    |> validate_required([:title, :description, :location, :skills])
  end
end
