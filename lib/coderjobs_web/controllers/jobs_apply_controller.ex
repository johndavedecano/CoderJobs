defmodule CoderjobsWeb.JobsApplyController do
    use CoderjobsWeb, :controller

    alias Coderjobs.Posts.JobActions
    alias Coderjobs.Others.Resume

    def new(conn, %{"id" => id}) do
      job = JobActions.find_by_id!(id)
      conn
      |> assign(:job, job)
      |> assign(:changeset, Resume.changeset(%Resume{}, %{}))
      |> render "new.html"
    end
  
    def create(conn, %{"id" => id}) do
      job = JobActions.find_by_id!(id)
      conn
      |> assign(:job, job)
      |> assign(:changeset, Resume.changeset(%Resume{}, %{}))
      |> render "new.html"
    end
end
  