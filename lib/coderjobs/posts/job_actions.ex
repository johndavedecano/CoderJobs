defmodule Coderjobs.Posts.JobActions do
  alias Coderjobs.Posts.Job
  alias Coderjobs.Repo

  def create(job_params \\ %{}, user_id) do
    %Job{}
    |> Job.submit_changeset(job_params, user_id)
    |> Repo.insert
  end

  def update(%Job{} = job, job_params \\ %{}, user_id) do
    job
    |> Job.submit_changeset(job_params, user_id)
    |> Repo.insert
  end

  def delete() do
    
  end
end
