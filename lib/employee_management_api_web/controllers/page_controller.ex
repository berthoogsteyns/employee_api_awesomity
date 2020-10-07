defmodule EmployeeManagementApiWeb.PageController do
  use EmployeeManagementApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
