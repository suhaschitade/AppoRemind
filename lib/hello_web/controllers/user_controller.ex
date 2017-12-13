defmodule HelloWeb.UserController do
  use HelloWeb, :controller
  alias Coherence.RegistrationController
  alias Hello.Accounts
  alias Hello.Accounts.User
  alias Hello.UserCompanies
  alias Hello.Accounts.User_Attribute
  alias Hello.Repo
 
  def index(conn, _params) do
    #IO.inspect(_params)
    conn
    |> Coherence.current_user
    |> IO.inspect()
    
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    companies = UserCompanies.list_companies()
    roles = Accounts.list_roles()
    render(conn, "new.html", changeset: changeset, companies: companies, roles: roles)
  end

  def create(conn, %{"user" => user_params}) do
    companies = UserCompanies.list_companies()
    roles = Accounts.list_roles()
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        {company_id, _} = Integer.parse(user_params["company_id"])
        {role_id, _} = Integer.parse(user_params["role_id"])
         user_attributes_changeset = %Hello.Accounts.User_Attribute{user_id: user.id, company_id: company_id , role_id: role_id , active: true} 
          |> Repo.insert()
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, companies: companies, roles: roles)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
