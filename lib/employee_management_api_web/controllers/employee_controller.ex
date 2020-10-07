defmodule EmployeeManagementApiWeb.EmployeeController do
  use EmployeeManagementApiWeb, :controller

  alias EmployeeManagementApi.Store
  alias EmployeeManagementApi.Store.Employee

  action_fallback EmployeeManagementApiWeb.FallbackController

  def index(conn, _params) do
    employees = Store.list_employees()
    render(conn, "index.json", employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- Store.create_employee(employee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.employee_path(conn, :show, employee))
      |> render("show.json", employee: employee)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Store.get_employee!(id)
    render(conn, "show.json", employee: employee)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Store.get_employee!(id)

    with {:ok, %Employee{} = employee} <- Store.update_employee(employee, employee_params) do
      render(conn, "show.json", employee: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Store.get_employee!(id)

    with {:ok, %Employee{}} <- Store.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end
end
