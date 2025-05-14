defmodule Freedpp.Repo.Migrations.ChangeUuidToBinaryId do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :uuid, :binary_id, null: false
    end
  end
end
