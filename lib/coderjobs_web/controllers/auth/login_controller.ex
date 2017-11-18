defmodule CoderjobsWeb.Auth.LoginController do
  use CoderjobsWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, _params) do
    render conn, "about.html"
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "You have successfully logged out.")
    |> redirect(to: "/login")
  end
end
