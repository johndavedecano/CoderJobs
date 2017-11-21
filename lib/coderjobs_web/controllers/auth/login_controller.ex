defmodule CoderjobsWeb.Auth.LoginController do
  use CoderjobsWeb, :controller
  
  alias Coderjobs.Account.UserAuthActions

  def new(conn, _params) do
    render conn, "new.html", csrf_token: get_csrf_token()
  end

  def create(conn, %{"email" => email, "password" => password}) do
    case UserAuthActions.login(email, password) do
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid username or password.")
        |> redirect(to: "/login")
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "You have successfully logged in.")
        |> redirect(to: "/jobs/submit")
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "You have successfully logged out.")
    |> redirect(to: "/login")
  end
end
