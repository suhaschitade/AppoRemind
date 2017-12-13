defmodule HelloWeb.StateController do
  use HelloWeb, :controller

  alias Hello.StateContext
  alias Hello.StateContext.State
  alias Hello.Common

  def index(conn, _params) do
    states = StateContext.list_states()
    render(conn, "index.html", states: states)
  end

  def new(conn, _params) do
    changeset = StateContext.change_state(%State{})
    map_countries = Common.lookup_countries()

    render(conn, "new.html", changeset: changeset, countries: map_countries)
  end

  def create(conn, %{"state" => state_params}) do
    case StateContext.create_state(state_params) do
      {:ok, state} ->
        conn
        |> put_flash(:info, "State created successfully.")
        |> redirect(to: state_path(conn, :show, state))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    state = StateContext.get_state!(id)
    render(conn, "show.html", state: state)
  end

  def edit(conn, %{"id" => id}) do
    state = StateContext.get_state!(id)
    changeset = StateContext.change_state(state)
    render(conn, "edit.html", state: state, changeset: changeset)
  end

  def statelist(conn, %{"id" =>id}) do
    states = StateContext.get_states_country(id)
    json conn, states
  end

  def update(conn, %{"id" => id, "state" => state_params}) do
    state = StateContext.get_state!(id)

    case StateContext.update_state(state, state_params) do
      {:ok, state} ->
        conn
        |> put_flash(:info, "State updated successfully.")
        |> redirect(to: state_path(conn, :show, state))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", state: state, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    state = StateContext.get_state!(id)
    {:ok, _state} = StateContext.delete_state(state)

    conn
    |> put_flash(:info, "State deleted successfully.")
    |> redirect(to: state_path(conn, :index))
  end
end
