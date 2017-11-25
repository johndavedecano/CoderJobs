defmodule Coderjobs.Posts.JobActions do
  alias Coderjobs.Posts.Job
  alias Coderjobs.Repo

  import Ecto.Query

  @doc false
  def list(params \\ %{}) do
    Job
    |> where([status: ^"active"])
    |> scope_by_search(params)
    |> scope_by_location(params)
    |> scope_by_latest
    |> preload([:user])
    |> Repo.paginate(params)
  end

  @doc false
  def list_by_user(user_id, params \\ %{}) do
    Job
    |> where(user_id: ^user_id)
    |> scope_by_status(params)
    |> scope_by_latest
    |> Repo.paginate(params)
  end

  def find_by_id(id) do
    Repo.get(Job, id) |> Repo.preload([:user])
  end

  @doc false
  def find_by_user(id, user_id) do
    Repo.get_by(Job, id: id, user_id: user_id)
  end

  @doc false
  def find_by_user!(id, user_id) do
    Repo.get_by!(Job, id: id, user_id: user_id)
  end

  def scope_by_search(query, params \\ %{}) do
    keyword = Map.get(params, "q", "")
    case keyword do
      "" -> query
      keyword ->
        query |> where([j], ilike(j.title, ^"%#{keyword}%"))
    end
  end

  def scope_by_location(query, params \\ %{}) do
    location = Map.get(params, "location", "")
    case location do
      "" -> query
      location -> where(query,  [location: ^location])
    end
  end

  @doc false
  def scope_by_status(query, params \\ %{}) do
    where(query,  [status: ^Map.get(params, "status", "active")])
  end

  @doc false
  def scope_by_latest(query) do
    order_by(query, desc: :updated_at)
  end

  @doc false
  def create(job_params \\ %{}, user_id) do
    %Job{}
    |> Job.submit_changeset(job_params, user_id)
    |> Repo.insert
  end

  @doc false
  def update(%Job{} = job, job_params \\ %{}, user_id) do
    job
    |> Job.submit_changeset(job_params, user_id)
    |> Repo.update
  end

  @doc false
  def repost(%Job{} = job) do
    job
    |> Job.repost_changeset
    |> Repo.update
  end

  @doc false
  def destroy(id, user_id) do
    job = Repo.get_by(Job, id: id, user_id: user_id)
    case job do
      nil -> {:error, "Unable to find resource"}
      job -> job |> Repo.delete
    end
  end
end