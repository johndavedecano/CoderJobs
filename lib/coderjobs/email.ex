defmodule Coderjobs.Mailer do
  use Bamboo.Mailer, otp_app: :coderjobs
end

defmodule Coderjobs.Email do
  use Bamboo.Phoenix, view: CoderjobsWeb.EmailView
  
  alias CoderjobsWeb.Endpoint

  @base_layout "email.html"
  @mail_from "John Dave Decano<info@coderjobs.ph>"
  @mail_reply_to "editors@coderjobs.ph"
  
  @message_subject_welcome "Welcome to CoderJobs.ph"
  @message_subject_reset "Password Reset"

  def welcome_email(user) do
    verification_url = make_url("register/" <> user.verification_code)
    base_email()
    |> to(user.email)
    |> subject(@message_subject_welcome)
    |> assign(:user, user)
    |> assign(:verification_url, verification_url)
    |> render("welcome.html")
  end

  def reset_email(user) do
    reset_url = make_url("reset/" <> user.verification_code)
    base_email()
    |> to(user.email)
    |> subject(@message_subject_reset)
    |> assign(:user, user)
    |> assign(:reset_url, reset_url)
    |> render("reset.html")
  end

  defp base_email() do
    new_email()
    |> from(@mail_from)
    |> put_header("Reply-To", @mail_reply_to)
    |> put_html_layout({CoderjobsWeb.LayoutView, @base_layout})
  end

  defp make_url(suffix) do
    Endpoint.url() <> "/" <> suffix
  end
end
