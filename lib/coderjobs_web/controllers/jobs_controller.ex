defmodule CoderjobsWeb.JobsController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Posts.Job
  alias Coderjobs.Posts.JobActions

  def index(conn, params \\ %{}) do
    user = Guardian.Plug.current_resource(conn)
    page = JobActions.list_by_user(user.id, params)
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

  def edit(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "edit.html", user: user, status: "")
  end

  def update(conn, %{"job" => job_params}) do
    user = Guardian.Plug.current_resource(conn)
    case JobActions.update(job_params, user.id) do
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

  def delete(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "edit.html", user: user, status: "")
  end
end
