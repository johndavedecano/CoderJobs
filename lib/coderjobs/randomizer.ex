defmodule Coderjobs.Randomizer do
  @moduledoc """
  Random string generator module.
  """
  
  @doc """
  Generate random string based on the given legth. It is also possible to generate certain type of randomise string using the options below:
  * :all - generate alphanumeric random string
  * :alpha - generate nom-numeric random string
  * :numeric - generate numeric random string
  * :upcase - generate upper case non-numeric random string
  * :downcase - generate lower case non-numeric random string
  ## Example
      iex> Iurban.String.randomizer(20) //"Je5QaLj982f0Meb0ZBSK"
  """
  def generate(length, type \\ :all) do
    alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers = "0123456789"

    lists =
      cond do
        type == :alpha -> alphabets <> String.downcase(alphabets)
        type == :numeric -> numbers
        type == :upcase -> alphabets
        type == :downcase -> String.downcase(alphabets)
        true -> alphabets <> String.downcase(alphabets) <> numbers
      end
      |> String.split("", trim: true)

    do_randomizer(length, lists)
  end

  @doc false
  defp get_range(length) when length > 1, do: (1..length)
  defp get_range(length), do: [1]

  @doc false
  defp do_randomizer(length, lists) do
    get_range(length)
    |> Enum.reduce([], fn(_, acc) -> [Enum.random(lists) | acc] end)
    |> Enum.join("")
  end
end