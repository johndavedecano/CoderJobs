defmodule Coderjobs.Others.Resume do
    use Ecto.Schema
  
    import Ecto.Changeset
  
    alias Coderjobs.Others.Resume
  
    schema "" do
      field :email, :string
      field :coverletter, :string
      field :name, :string
      field :github, :string
      field :website, :string
      field :resume, :string
      field :mobile, :string
      timestamps()
    end
  
    def changeset(%Resume{} = form, attrs \\ %{}) do
      form
      |> cast(attrs, [:email, :coverletter, :name, :website, :github, :resume, :mobile])
      |> validate_required([:email, :resume, :name])
      |> validate_format(:email, ~r/@/)
    end
  end
  