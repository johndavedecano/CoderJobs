defmodule CoderjobsWeb.Helpers.Twbs4FormHelper do
  import Phoenix.HTML.Tag
  import Phoenix.HTML.Form

  def twbs4_error_tag(form, field) do
    if error = form.errors[field] do
      {message, _} = error
      IO.inspect message
      content_tag :div, humanize(field) <> " " <> message, class: "invalid-feedback"
    end
  end
  
  def twbs4_text_input_tag_lg(form, field, opts \\ []) do
    class_name = Keyword.get(opts, :class, "form-control form-control-lg")
    if form.errors[field] do
      custom_opts = Keyword.put(opts, :class, class_name <> " is-invalid")
      text_input form, field, custom_opts
    else
      custom_opts = Keyword.put(opts, :class, class_name)
      text_input form, field, custom_opts
    end
  end

  def twbs4_text_input_tag(form, field, opts \\ []) do
    class_name = Keyword.get(opts, :class, "form-control")
    if form.errors[field] do
      custom_opts = Keyword.put(opts, :class, class_name <> " is-invalid")
      text_input form, field, custom_opts
    else
      custom_opts = Keyword.put(opts, :class, class_name)
      text_input form, field, custom_opts
    end
  end
end