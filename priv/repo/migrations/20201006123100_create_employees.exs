defmodule EmployeeManagementApi.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :national_id, :string
      add :phone, :string
      add :email, :string
      add :date_of_birth, :date
      add :status, :boolean, default: false, null: false
      add :position, :string

      timestamps()
    end

  end
end
