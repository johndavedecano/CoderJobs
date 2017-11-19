defmodule CoderjobsWeb.Auth.RegisterController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Account.User
  alias Coderjobs.Account.UserAuthActions

  def new(conn, _params) do
    changeset = User.register_changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    case UserAuthActions.create(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Please check your email #{user.email} to verify your account.")
        |> redirect(to: "/")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def verify(conn, %{"code" => code}) do
    case UserAuthActions.verify(code) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Account verification success. Please update your company details.")
        |> redirect(to: "/account")
      {:error, _} ->
        conn
        |> put_flash(:error, "Account verification failed.")
        |> redirect(to: "/")
    end
  end  
end
