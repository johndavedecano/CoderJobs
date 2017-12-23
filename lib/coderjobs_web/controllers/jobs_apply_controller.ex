defmodule CoderjobsWeb.JobsApplyController do
    use CoderjobsWeb, :controller

    alias Coderjobs.Posts.JobActions
    alias Coderjobs.Others.Resume
    alias Coderjobs.Email
    alias Coderjobs.Mailer

    def new(conn, %{"id" => id}) do
      job = JobActions.find_by_id!(id)
      conn
      |> assign(:job, job)
      |> assign(:changeset, Resume.changeset(%Resume{}, %{}))
      |> render "new.html"
    end

    def send_application(conn, resume_params, job) do
      Email.send_application(resume_params, job) |> Mailer.deliver_now
      conn
    end
  
    def create(conn, %{"id" => id, "resume" => resume_params}) do
      job = JobActions.find_by_id!(id)
      changeset = Resume.changeset(%Resume{}, resume_params)

      if changeset.valid? do
        conn 
        |> put_flash(:info, "Application was successfully sent.")
        |> send_application(resume_params, job)
        |> redirect(to: "/jobs/" <> job.id)
      else
        conn
        |> assign(:job, job)
        |> assign(:changeset, %{changeset | action: :create})
        |> render "new.html"
      end
    end
end
  