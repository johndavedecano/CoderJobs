defmodule Coderjobs.Posts.JobActions do
  alias Coderjobs.Posts.Job
  alias Coderjobs.Repo

  import Ecto.Query

  @doc false
  def list_by_user(user_id, params) do
    Job
    |> where(user_id: ^user_id)
    |> scope_by_status(params)
    |> scope_by_latest
    |> Repo.paginate(params)
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
    |> Repo.insert
  end

  @doc false
  def delete() do
    
  end
end