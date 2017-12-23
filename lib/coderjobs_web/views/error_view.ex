defmodule CoderjobsWeb.ErrorView do
  use CoderjobsWeb, :view

  def render("404.html", _assigns) do
    render("error.html", message: "Page not found")
  end

  def render("500.html", _assigns) do
    render("error.html", message: "Internal Server Error")  
  end

  def render("403.html", _assigns) do
    render("error.html", message: "Forbidden")  
  end

  def render("401.html", _assigns) do
    render("error.html", message: "Unauthorized")  
  end

  def render("400.html", _assigns) do
    render("error.html", message: "Bad Request")  
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
