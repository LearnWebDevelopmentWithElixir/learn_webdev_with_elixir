defmodule LearnWebdevWithElixir.Fixture do

    alias LearnWebdevWithElixir.{Accounts,Content}
    use LearnWebdevWithElixir.FixtureParams 

    def user_fixture(attrs \\ @valid_user_attrs) do
        attrs
            |> Accounts.create_user()
    end

    def post_fixture(attrs \\ @valid_post_attrs) do
        {:ok, user} = user_fixture()
        Content.create_post(user,attrs)
    end    

    def comment_fixture(attrs \\ @valid_comment_attrs) do
        {:ok, post} = post_fixture()
        {:ok, user} = user_fixture(@valid_user_comment_attrs)
        Content.create_comment(post,user, attrs)
    end

    def page_fixture(attrs \\ @valid_page_attrs) do
        attrs
        |> Content.create_page()
    end


end