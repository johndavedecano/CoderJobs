defmodule CoderjobsWeb.Auth.ResetController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Account.UserAuthActions

  def new(conn, %{"code" => reset_code}) do
    case UserAuthActions.check_reset_code(reset_code) do
      {:ok, _} ->
        render(conn, "new.html", reset_code: reset_code, csrf_token: get_csrf_token())
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def create(conn, %{"reset_code" => reset_code, "password" => password, "password_confirmation" => password_confirmation}) do
    case UserAuthActions.update_password(password, password_confirmation, reset_code) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Password has been successfully updated.")
        |> redirect(to: "/login")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/reset/" <> reset_code)
    end
  end
end
