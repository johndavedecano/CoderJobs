defmodule CoderjobsWeb.PageController do
  use CoderjobsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end

  def contact_post(conn, _params) do
    render conn, "contact.html"
  end

  def terms(conn, _params) do
    render conn, "terms.html"
  end
end
