defmodule CoderjobsWeb.JobsController do
  use CoderjobsWeb, :controller

  # alias Coderjobs.Account.User

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", user: user)
  end

  def new(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "new.html", user: user)
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
