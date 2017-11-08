defmodule CoderjobsWeb.AccountController do
  use CoderjobsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
