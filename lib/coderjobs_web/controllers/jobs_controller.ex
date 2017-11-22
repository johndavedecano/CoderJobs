defmodule CoderjobsWeb.JobsController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Posts.Job

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", user: user)
  end

  def new(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    changeset = Job.submit_changeset(%Job{}, %{}, user.id)
    render(conn, "new.html", changeset: changeset, user: user)
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
