defmodule Freedpp.Repo.Migrations.CreateStreamsTable do
  use Ecto.Migration

  def change do
    create table(:streams, primary_key: false) do
      add :stream_id, :binary_id, primary_key: true
      add :stream_uuid, :uuid, null: false
      add :stream_version, :integer, null: false
      add :created_at, :naive_datetime, null: false
      add :deleted_at, :naive_datetime
    end

    create index(:streams, [:stream_uuid])
  end
end
