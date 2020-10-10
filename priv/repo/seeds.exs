# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EmployeeManagementApi.Repo.insert!(%EmployeeManagementApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.



EmployeeManagementApi.Repo.insert!(%EmployeeManagementApi.Store.Employee{
    name: "Bert Hoogsteyns",
    email: "berthoogsteyns@gmail.com",
    date_of_birth: ~D[1997-06-23],
    national_id: "000000000",
    phone: "+250 000 000 000",
    position: "developer",
    status: true

}, )
