defmodule EmployeeManagementApiWeb.EmployeeControllerTest do
  use EmployeeManagementApiWeb.ConnCase
  require :logger

  alias EmployeeManagementApi.Store
  alias EmployeeManagementApi.Store.Employee

  @create_attrs %{
    date_of_birth: ~D[2010-04-17],
    email: "some email",
    name: "some name",
    national_id: "some national_id",
    phone: "some phone",
    position: "some position",
    status: true
  }
  @update_attrs %{
    date_of_birth: ~D[2011-05-18],
    email: "some updated email",
    name: "some updated name",
    national_id: "some updated national_id",
    phone: "some updated phone",
    position: "some updated position",
    status: false
  }
  @invalid_attrs %{date_of_birth: nil, email: nil, name: nil, national_id: nil, phone: nil, position: nil, status: nil}

  def fixture(:employee) do
    {:ok, employee} = Store.create_employee(@create_attrs)
    employee
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all employees", %{conn: conn} do
      conn = get(conn, Routes.employee_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employee" do
    test "renders employee when data is valid", %{conn: conn} do
      conn = post(conn, Routes.employee_path(conn, :create), employee: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "date_of_birth" => "2010-04-17",
               "email" => "some email",
               "name" => "some name",
               "national_id" => "some national_id",
               "phone" => "some phone",
               "position" => "some position",
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.employee_path(conn, :create), employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup [:create_employee]

    test "renders employee when data is valid", %{conn: conn, employee: %Employee{id: id} = employee} do
      conn = put(conn, Routes.employee_path(conn, :update, employee), employee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.employee_path(conn, :show, id))

      assert %{
               "id" => id,
               "date_of_birth" => "2011-05-18",
               "email" => "some updated email",
               "name" => "some updated name",
               "national_id" => "some updated national_id",
               "phone" => "some updated phone",
               "position" => "some updated position",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      conn = put(conn, Routes.employee_path(conn, :update, employee), employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup [:create_employee]

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, Routes.employee_path(conn, :delete, employee))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.employee_path(conn, :show, employee))
      end
    end
  end

  defp create_employee(_) do
    employee = fixture(:employee)
    %{employee: employee}
  end
end
