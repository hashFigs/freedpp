defmodule Freedpp.Repo.Migrations.ChangeUuidToString do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :uuid, :string, from: :uuid
    end
  end
end
