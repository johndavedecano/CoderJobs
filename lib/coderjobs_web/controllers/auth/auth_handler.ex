defmodule CoderjobsWeb.Auth.AuthHandler  do
  
  use CoderjobsWeb , :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: "/login")
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: "/login")
  end
end
