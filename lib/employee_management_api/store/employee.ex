defmodule EmployeeManagementApi.Store.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "employees" do
    field :date_of_birth, :date
    field :email, :string
    field :name, :string
    field :national_id, :string
    field :phone, :string
    field :position, :string
    field :status, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :national_id, :phone, :email, :date_of_birth, :status, :position])
    |> validate_required([:name, :national_id, :phone, :email, :date_of_birth, :status, :position])
  end
end
