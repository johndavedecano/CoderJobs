defmodule CoderjobsWeb.PageController do
  use CoderjobsWeb, :controller

  alias Coderjobs.Posts.JobActions

  def index(conn, params \\ %{}) do
    page = JobActions.list(params)
    render(conn, "index.html",
      jobs: page.entries,
      page: page,
      total: page.total_entries,
      q: Map.get(params, "q", ""),
      location: Map.get(params, "location", ""),
    )
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html",
      csrf_token: get_csrf_token(),
      email: "",
      message: ""
  end

  def contact_post(conn, %{"email" => email, "message" => message}) do
    render conn,
      "contact.html",
      csrf_token: get_csrf_token(),
      email: email,
      message: message
  end

  def terms(conn, _params) do
    render conn, "terms.html"
  end
end
