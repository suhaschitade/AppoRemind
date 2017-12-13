defmodule HelloWeb.CompanyController do
  use HelloWeb, :controller

  alias Hello.UserCompanies
  alias Hello.UserCompanies.Company
  alias Hello.Common

  def index(conn, _params) do
    companies = UserCompanies.list_companies()
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = UserCompanies.change_company(%Company{})
    lookup_companies = Common.lookup_countries()
    render(conn, "new.html", changeset: changeset, countries: lookup_companies)
  end

  def create(conn, %{"company" => company_params}) do
    case UserCompanies.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: company_path(conn, :show, company))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = UserCompanies.get_company!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = UserCompanies.get_company!(id)
    changeset = UserCompanies.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = UserCompanies.get_company!(id)

    case UserCompanies.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: company_path(conn, :show, company))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = UserCompanies.get_company!(id)
    {:ok, _company} = UserCompanies.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: company_path(conn, :index))
  end
end
