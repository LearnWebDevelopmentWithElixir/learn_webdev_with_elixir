defmodule LearnWebdevWithElixir.FixtureParams do
    defmacro __using__(_) do
        quote do
            @valid_user_attrs %{first_name: "first name", last_name: "last name", email: "user-#{Enum.random(1..1_000)}@foo.com", password: "password"}
            @update_user_attrs %{first_name: "some first name", last_name: "updated last name", permissions: ["admin"]}
            @invalid_user_attrs %{email: nil}
            @invalid_user_update_attrs %{email: nil}
            @valid_user_comment_attrs  %{first_name: "first name", last_name: "last name", email: "user-#{Enum.random(1..1_000)}@foo.com", password: "password"}               

            @valid_post_attrs %{body: "some body", title: "some title"}
            @update_post_attrs %{body: "some updated body", title: "some updated title"}
            @invalid_post_attrs %{body: nil, title: nil}

            @valid_comment_attrs %{body: "some comment"}
            @update_comment_attrs %{body: "some updated comment"}
            @invalid_comment_attrs %{body: nil}

            @valid_page_attrs %{body: "some body", title: "some title"}
            @update_page_attrs %{body: "some updated body", title: "some updated title"}
            @invalid_page_attrs %{body: nil, title: nil}

            @valid_login_attrs %{email: "user-#{Enum.random(1..1_000)}@foo.com", password: "password"}
            @invalid_login_password_attrs %{email: "user-#{Enum.random(1..1_000)}@foo.com", password: "psswrd"}
            @invalid_login_email_attrs %{email: "invaliduser-#{Enum.random(1..1_000)}@foo.com", password: "password"}

        end
    end
end