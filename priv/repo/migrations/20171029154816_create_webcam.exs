defmodule Whitebox.Repo.Migrations.CreateWebcam do
  use Ecto.Migration

  def change do
    create table(:webcams, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)

      timestamps()
    end
    create index(:webcams, [:user_id])
  end
end
