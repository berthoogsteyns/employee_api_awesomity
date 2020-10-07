defmodule EmployeeManagementApiWeb.EmployeeView do
  use EmployeeManagementApiWeb, :view
  alias EmployeeManagementApiWeb.EmployeeView

  def render("index.json", %{employees: employees}) do
    %{data: render_many(employees, EmployeeView, "employee.json")}
  end

  def render("show.json", %{employee: employee}) do
    %{data: render_one(employee, EmployeeView, "employee.json")}
  end

  def render("employee.json", %{employee: employee}) do
    %{id: employee.id,
      name: employee.name,
      national_id: employee.national_id,
      phone: employee.phone,
      email: employee.email,
      date_of_birth: employee.date_of_birth,
      status: employee.status,
      position: employee.position}
  end
end
