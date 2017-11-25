defmodule CoderjobsWeb.Helpers.TextHelper do
  def truncate(text, opts \\ []) do
    max_length  = opts[:max_length] || 60
    omission    = opts[:omission] || "..."
    cond do
        not String.valid?(text) -> 
        text
        String.length(text) < max_length -> 
        text
        true ->
        length_with_omission = max_length - String.length(omission)

        "#{String.slice(text, 0, length_with_omission)}#{omission}"
    end
  end

  def get_location(key) do
    locations = Application.get_env(:coderjobs, :locations)
    Map.get(locations, key, "")
  end
end