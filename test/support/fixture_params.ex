defmodule LearnWebdevWithElixir.FixtureParams do
    defmacro __using__(_) do
        quote do
            @valid_user_attrs %{first_name: "first name", last_name: "last name", email: "user-#{Enum.random(1..1_000)}@foo.com", password: "password"}
            @valid_user_attrs_1 %{first_name: "first name One", last_name: "last name One", email: "userOne-#{Enum.random(1..1_000)}@foo.com", password: "password"}
            @update_user_attrs %{"first_name" => "some first name", "last_name" => "updated last name", "permissions" => "admin"}
            @invalid_user_attrs %{email: nil}
            @invalid_user_update_attrs %{email: nil}
            @valid_user_comment_attrs  %{first_name: "first name", last_name: "last name", email: "user-#{Enum.random(1..1_000)}@foo.com", password: "password"}               

            @valid_post_attrs %{body: "some body", title: "some title"}
            @valid_posts_attrs_1 %{body: "some body", title: "some title #1"}
            @valid_posts_attrs_2 %{body: "some body", title: "some title #2"}
            @valid_posts_attrs_3 %{body: "some body", title: "some title #3"}
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

            @valid_subscriber_attrs %{"email" => "user-#{Enum.random(1..1_000)}@foo.com"}
            @invalid_subscriber_attrs %{"email" => nil}
            @exists_subscriber_attrs %{"email" => "user-#{Enum.random(1..1_000)}@foo.com"}
        end
    end
end