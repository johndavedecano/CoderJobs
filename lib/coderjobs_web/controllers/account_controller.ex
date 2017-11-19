defmodule CoderjobsWeb.AccountController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Account.User

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    changeset = User.account_changeset(user, %{})
    render conn, "index.html", changeset: changeset
  end

  def update(conn, _params) do
    
  end
end
