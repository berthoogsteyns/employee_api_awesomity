defmodule EmployeeManagementApi.Repo do
  use Ecto.Repo,
    otp_app: :employee_management_api,
    adapter: Ecto.Adapters.Postgres
end
