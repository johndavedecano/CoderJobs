defmodule CoderjobsWeb.Auth.RegisterController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Account.User
  alias Coderjobs.Account.UserActions

  def new(conn, _params) do
    changeset = User.register_changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case UserActions.create(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Please check your email #{user.email} to verify your account.")
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def verify(conn, %{"code" => code}) do
    json(conn, code) |> put_status 403
  end  
end
