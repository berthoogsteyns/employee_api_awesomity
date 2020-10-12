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

# TODO custom validation for age, phone number
  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :national_id, :phone, :email, :date_of_birth, :status, :position])
    |> validate_required([:name, :national_id, :phone, :email, :date_of_birth, :status, :position])
    |> validate_length(:national_id, min: 16)
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_format(:phone, ~r/^[+][2][5][0]+[7][8]+[0-9]{7}/)
    |> unique_constraint(:email)
    |> unique_constraint(:national_id)
    |> unique_constraint(:phone)
  end

  # defp validate_age(changeset, age_field) do
  #   age = get_field(changeset, age_field)

  # end
end
