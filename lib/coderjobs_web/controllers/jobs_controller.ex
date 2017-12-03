defmodule CoderjobsWeb.JobsController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Posts.Job
  alias Coderjobs.Posts.JobActions

  def show(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    job = JobActions.find_by_id(id, user)
    case job do
      nil ->
        conn
        |> put_status(404)
        |> put_view(CoderjobsWeb.ErrorView)
        |> render("404.html")
      job ->
        render(conn, "show.html", job: job)
    end
  end

  def index(conn, params \\ %{}) do
    user = Guardian.Plug.current_resource(conn)
    page = JobActions.list_by_user(user, params)
    render(conn, "index.html",
      user: user,
      jobs: page.entries,
      page: page,
      total: page.total_entries,
      status: Map.get(params, "status", "active")
    )
  end

  def new(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, "new.html",
      changeset: Job.submit_changeset(%Job{}, %{}, user.id),
      user: user,
      locations: get_locations(),
      salary_ranges: Application.get_env(:coderjobs, :salary_ranges),
      status: ""
  end

  defp get_locations() do
    Application.get_env(:coderjobs, :locations)
    |> Enum.map(fn {k, v} -> {v, k} end)
  end

  def create(conn, %{"job" => job_params}) do
    user = Guardian.Plug.current_resource(conn)
    case JobActions.create(job_params, user.id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Job was successfully submitted.")
        |> redirect(to: "/jobs")
      {:error, changeset} ->
        render conn, "new.html",
          changeset: changeset,
          user: user,
          locations: get_locations(),
          salary_ranges: Application.get_env(:coderjobs, :salary_ranges),
          status: ""
    end
  end

  def repost(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    job = JobActions.find_by_user!(id, user.id)
    case JobActions.repost(job) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Job was successfully reposted.")
        |> redirect(to: "/jobs")
      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to perform such operation.")
        |> redirect(to: "/jobs")
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    job = JobActions.find_by_user(id, user)
    case job do
      nil ->
        conn
        |> put_flash(:error, "Cannot find job.")
        |> redirect(to: "/jobs")
      job ->
        render conn, "edit.html",
        changeset: Job.update_changeset(job, %{}),
        user: user,
        job: job,
        locations: get_locations(),
        salary_ranges: Application.get_env(:coderjobs, :salary_ranges),
        status: ""
    end
  end

  def update(conn, %{"job" => job_params, "id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    job = JobActions.find_by_user!(id, user)
    case JobActions.update(job, job_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Job was successfully submitted.")
        |> redirect(to: "/jobs")
      {:error, changeset} ->
        render conn, "new.html",
          changeset: changeset,
          user: user,
          locations: get_locations(),
          salary_ranges: Application.get_env(:coderjobs, :salary_ranges),
          status: ""
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)
    case JobActions.destroy(id, user) do
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/jobs")
      {:ok, _} ->
        conn
        |> put_flash(:info, "Job was successfully deleted.")
        |> redirect(to: "/jobs")
    end
  end
end
