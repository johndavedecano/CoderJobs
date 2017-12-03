defmodule CoderjobsWeb.AccountController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Account.User
  alias Coderjobs.Account.UserAccountActions

  def show(conn, %{"id" => id}) do
    try do
      user = UserAccountActions.find_by_id!(id)
      render(conn, "show.html", user: user, page: "general")
    rescue
      Ecto.NoResultsError ->
        conn
        |> put_status(404)
        |> put_view(CoderjobsWeb.ErrorView)
        |> render("404.html")  
    end
  end

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    changeset = User.account_changeset(user, %{})
    render(conn, "index.html", changeset: changeset, user: user, page: "general")
  end

  def update(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)
    case UserAccountActions.update(user, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account was successfully updated.")
        |> redirect(to: "/account")
      {:error, changeset} ->
        render(conn, "index.html", changeset: changeset, user: user, page: "general")
    end
  end

  def index_password(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    changeset = User.password_changeset(user, %{})
    render(conn, "password.html", changeset: changeset, user: user, page: "password")
  end

  def update_password(conn, %{"user" => user_params}) do
    user = Guardian.Plug.current_resource(conn)
    case UserAccountActions.update_password(user, user_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account password was successfully updated.")
        |> redirect(to: "/account/password")
      {:error, changeset} ->
        render(conn, "password.html", changeset: changeset, page: "password")
    end
  end
end
