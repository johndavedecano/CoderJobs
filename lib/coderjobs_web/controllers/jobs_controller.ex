defmodule CoderjobsWeb.JobsController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Posts.Job

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", user: user)
  end

  def new(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, "new.html",
      changeset: Job.submit_changeset(%Job{}, %{}, user.id),
      user: user,
      locations: get_locations(),
      salary_ranges: Application.get_env(:coderjobs, :salary_ranges)
  end

  defp get_locations() do
    Application.get_env(:coderjobs, :locations)
    |> Enum.map(fn {k, v} -> {v, k} end)
  end

  def create(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "new.html", user: user)
  end

  def edit(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "edit.html", user: user)
  end

  def delete(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "edit.html", user: user)
  end
end
