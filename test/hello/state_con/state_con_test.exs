defmodule Hello.StateConTest do
  use Hello.DataCase

  alias Hello.StateCon

  describe "states" do
    alias Hello.StateCon.State

    @valid_attrs %{active: true, name: "some name", twolettercode: "some twolettercode"}
    @update_attrs %{active: false, name: "some updated name", twolettercode: "some updated twolettercode"}
    @invalid_attrs %{active: nil, name: nil, twolettercode: nil}

    def state_fixture(attrs \\ %{}) do
      {:ok, state} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StateCon.create_state()

      state
    end

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert StateCon.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert StateCon.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      assert {:ok, %State{} = state} = StateCon.create_state(@valid_attrs)
      assert state.active == true
      assert state.name == "some name"
      assert state.twolettercode == "some twolettercode"
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StateCon.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      assert {:ok, state} = StateCon.update_state(state, @update_attrs)
      assert %State{} = state
      assert state.active == false
      assert state.name == "some updated name"
      assert state.twolettercode == "some updated twolettercode"
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = StateCon.update_state(state, @invalid_attrs)
      assert state == StateCon.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = StateCon.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> StateCon.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = StateCon.change_state(state)
    end
  end
end
