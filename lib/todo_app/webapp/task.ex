defmodule TodoApp.Webapp.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :name, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :status])
    |> validate_required([:name, :description, :status])
  end
end
