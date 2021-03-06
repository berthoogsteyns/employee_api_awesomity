defmodule EmployeeManagementApiWeb.EmployeeController do
  require Logger
  use EmployeeManagementApiWeb, :controller

  alias EmployeeManagementApi.Store
  alias EmployeeManagementApi.Store.Employee

  action_fallback EmployeeManagementApiWeb.FallbackController

  def index(conn, _params) do
    employees = Store.list_employees()
    render(conn, "index.json", employees: employees)
  end

  def search(conn, %{"search_querry" => search_querry}) do
    employee = Store.get_employee!(search_querry)

    render(conn, "show.json", employee: employee)
  end

  def activate(conn, %{"employee_id" => employee_id}) do
    employee = Store.get_employee!(employee_id)

    activated = %{
      id: employee.id,
      name: employee.name,
      national_id: employee.national_id,
      phone: employee.phone,
      email: employee.email,
      date_of_birth: employee.date_of_birth,
      status: true,
      position: employee.position
    }

    with {:ok, %Employee{} = employee} <- Store.update_employee(employee, activated) do
      render(conn, "show.json", employee: employee)
    end
  end

  def suspend(conn, %{"employee_id" => employee_id}) do
    employee = Store.get_employee!(employee_id)

    suspended = %{
      id: employee.id,
      name: employee.name,
      national_id: employee.national_id,
      phone: employee.phone,
      email: employee.email,
      date_of_birth: employee.date_of_birth,
      status: false,
      position: employee.position
    }

    with {:ok, %Employee{} = employee} <- Store.update_employee(employee, suspended) do
      render(conn, "show.json", employee: employee)
    end
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
