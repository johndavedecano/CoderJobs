defmodule Coderjobs.Posts.Job do
  use Ecto.Schema

  import Ecto.Changeset
  
  alias Coderjobs.Posts.Job

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
    belongs_to :user, Coderjobs.Account.User
    timestamps()
  end

  def validate_url(changeset, field, options \\ []) do
    validate_change changeset, field, fn _, url ->
      case url |> String.to_charlist |> :http_uri.parse do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || "invalid url: #{inspect msg}"}]
      end
    end
  end

  defp get_locations() do
    Map.keys(Application.get_env(:coderjobs, :locations))
  end

  @doc false
  def submit_changeset(%Job{} = job, attrs, user_id) do
    job
    |> cast(attrs, [:description, :user_id, :is_external, :is_remote, :location, :salary, :skills, :title, :url, :status])
    |> validate_url(:url, message: "URL is not a valid URL!")
    |> validate_required([:title, :description, :skills, :status])
    |> validate_inclusion(:status, ["active", "draft"])
    |> validate_inclusion(:location, get_locations())
    |> validate_length(:title, min: 10, max: 60)
    |> validate_length(:description, max: 5000)
    |> put_change(:user_id, user_id)
  end

  @doc false
  def repost_changeset(%Job{} = job) do
    job
    |> cast(%{}, [])
    |> put_change(:inserted_at, NaiveDateTime.utc_now())
    |> put_change(:update_at, NaiveDateTime.utc_now())
    |> put_change(:status, "active")
  end
end
