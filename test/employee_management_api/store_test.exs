defmodule EmployeeManagementApi.StoreTest do
  use EmployeeManagementApi.DataCase

  alias EmployeeManagementApi.Store

  describe "employees" do
    alias EmployeeManagementApi.Store.Employee

    @valid_attrs %{date_of_birth: ~D[2010-04-17], email: "some email", name: "some name", national_id: "some national_id", phone: "some phone", position: "some position", status: true}
    @update_attrs %{date_of_birth: ~D[2011-05-18], email: "some updated email", name: "some updated name", national_id: "some updated national_id", phone: "some updated phone", position: "some updated position", status: false}
    @invalid_attrs %{date_of_birth: nil, email: nil, name: nil, national_id: nil, phone: nil, position: nil, status: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Store.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Store.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Store.create_employee(@valid_attrs)
      assert employee.date_of_birth == ~D[2010-04-17]
      assert employee.email == "some email"
      assert employee.name == "some name"
      assert employee.national_id == "some national_id"
      assert employee.phone == "some phone"
      assert employee.position == "some position"
      assert employee.status == true
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Store.update_employee(employee, @update_attrs)
      assert employee.date_of_birth == ~D[2011-05-18]
      assert employee.email == "some updated email"
      assert employee.name == "some updated name"
      assert employee.national_id == "some updated national_id"
      assert employee.phone == "some updated phone"
      assert employee.position == "some updated position"
      assert employee.status == false
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_employee(employee, @invalid_attrs)
      assert employee == Store.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Store.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Store.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Store.change_employee(employee)
    end
  end
end
