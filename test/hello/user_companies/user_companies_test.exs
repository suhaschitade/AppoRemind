defmodule Hello.UserCompaniesTest do
  use Hello.DataCase

  alias Hello.UserCompanies

  describe "companies" do
    alias Hello.UserCompanies.Company

    @valid_attrs %{active: true, address1: "some address1", address2: "some address2", city: "some city", logo: "some logo", name: "some name", weburl: "some weburl", zipcode: "some zipcode"}
    @update_attrs %{active: false, address1: "some updated address1", address2: "some updated address2", city: "some updated city", logo: "some updated logo", name: "some updated name", weburl: "some updated weburl", zipcode: "some updated zipcode"}
    @invalid_attrs %{active: nil, address1: nil, address2: nil, city: nil, logo: nil, name: nil, weburl: nil, zipcode: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserCompanies.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert UserCompanies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert UserCompanies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = UserCompanies.create_company(@valid_attrs)
      assert company.active == true
      assert company.address1 == "some address1"
      assert company.address2 == "some address2"
      assert company.city == "some city"
      assert company.logo == "some logo"
      assert company.name == "some name"
      assert company.weburl == "some weburl"
      assert company.zipcode == "some zipcode"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserCompanies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, company} = UserCompanies.update_company(company, @update_attrs)
      assert %Company{} = company
      assert company.active == false
      assert company.address1 == "some updated address1"
      assert company.address2 == "some updated address2"
      assert company.city == "some updated city"
      assert company.logo == "some updated logo"
      assert company.name == "some updated name"
      assert company.weburl == "some updated weburl"
      assert company.zipcode == "some updated zipcode"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = UserCompanies.update_company(company, @invalid_attrs)
      assert company == UserCompanies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = UserCompanies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> UserCompanies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = UserCompanies.change_company(company)
    end
  end
end
