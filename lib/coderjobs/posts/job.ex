defmodule Coderjobs.Posts.Job do
  use Ecto.Schema

  import Ecto.Changeset
  
  alias Coderjobs.Posts.Job

  @valid_locations [
    "manila",
    "quezon-city",
    "cebu",
    "davao",
    "caloocan",
    "pasay",
    "las-piñas",
    "makati",
    "malabon",
    "mandaluyong",
    "marikina", 
    "muntinlupa",
    "Navotas", 
    "parañaque",
    "pasig",
    "san-juan",
    "taguig",
    "valenzuela",
    "pampanga",
    "pateros"
  ]


  schema "jobs" do
    field :description, :string
    field :is_external, :boolean, default: false
    field :is_remote, :boolean, default: false
    field :location, :string
    field :salary, :string, default: "Not Specified"
    field :status, :string, default: "active"
    field :skills, :string
    field :title, :string
    field :url, :string
    field :user_id, :integer
    timestamps()
  end

  @doc false
  def submit_changeset(%Job{} = job, attrs, user_id) do
    job
    |> cast(attrs, [:description, :user_id, :is_external, :is_remote, :location, :salary, :skills, :title, :url])
    |> validate_required([:title, :description, :location, :skills, :status])
    |> validate_inclusion(:status, ["active", "draft"])
    |> validate_inclusion(:location, @valid_locations)
    |> put_change(:user_id, user_id)
  end

end
