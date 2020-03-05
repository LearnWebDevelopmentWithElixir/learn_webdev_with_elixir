defmodule LearnWebdevWithElixir.AccountsTest do
  use LearnWebdevWithElixir.DataCase

  alias LearnWebdevWithElixir.Accounts
  
  describe "users" do    
    use LearnWebdevWithElixir.FixtureParams
    alias LearnWebdevWithElixir.Fixture
    alias LearnWebdevWithElixir.Accounts.User

    @tag run: true
    test "list_users/0 returns all users" do
        assert is_list(Accounts.list_users())
    end

    @tag run: true
    test "get_user!/1 returns the user with given id" do
      {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
      assert Accounts.get_user!(user.id).email == user.email
    end

    @tag run: true
    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Fixture.user_fixture(@valid_user_attrs)
      assert user.first_name == @valid_user_attrs.first_name
    end

    @tag run: true
    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fixture.user_fixture(@invalid_user_attrs)
    end

    @tag run: true
    test "update_user/2 with valid data updates the user" do
      {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_user_attrs)
      assert user.first_name == @update_user_attrs.first_name
    end

    @tag run: true
    test "update_user/2 with invalid data returns error changeset" do
      {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_user_update_attrs)
      assert user.first_name == Accounts.get_user!(user.id).first_name
    end

    @tag run: true
    test "delete_user/1 deletes the user" do
      {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    @tag run: true
    test "change_user/1 returns a user changeset" do
      {:ok, user} = Fixture.user_fixture(@valid_user_attrs)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end

    @tag run: true
    test "check unique constraint for email" do
      _user = Fixture.user_fixture(@valid_user_attrs)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@valid_user_attrs)
    end
  end
end
