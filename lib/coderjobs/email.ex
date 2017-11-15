defmodule Coderjobs.Mailer do
  use Bamboo.Mailer, otp_app: :coderjobs
end

defmodule Coderjobs.Email do
  use Bamboo.Phoenix, view: CoderjobsWeb.EmailView

  def welcome_email(user) do
    base_email()
    |> to(user.email)
    |> subject("Welcome to CoderJobs.ph")
    |> assign(:user, user)
    |> render("welcome.html")
  end

  defp base_email() do
    new_email()
    |> from("John Dave Decano<info@coderjobs.ph>")
    |> put_header("Reply-To", "editors@coderjobs.ph")
    |> put_html_layout({CoderjobsWeb.LayoutView, "email.html"})
  end
end
