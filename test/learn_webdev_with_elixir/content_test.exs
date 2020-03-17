defmodule LearnWebdevWithElixir.ContentTest do
  use LearnWebdevWithElixir.DataCase
  alias LearnWebdevWithElixir.Content

  describe "posts" do
    use LearnWebdevWithElixir.FixtureParams
    alias LearnWebdevWithElixir.Content.Post
    alias LearnWebdevWithElixir.{Content, Fixture}

    @tag run: true
    test "list_posts/0 returns all posts" do
      {:ok, %Post{} = _post} = Fixture.post_fixture(@valid_post_attrs)
      assert is_list(Content.list_posts())
    end

    @tag run: true
    test "get_post!/1 returns the post with given id" do
      {:ok, post} = Fixture.post_fixture()
      assert Content.get_post!(post.id).id == post.id
    end

    @tag run: true
    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Fixture.post_fixture(@valid_post_attrs)
      assert post.body == @valid_post_attrs.body
      assert post.title == @valid_post_attrs.title
    end

    @tag run: true
    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fixture.post_fixture(@invalid_post_attrs)
    end

    @tag run: true
    test "update_post/2 with valid data updates the post" do
      {:ok,post} = Fixture.post_fixture(@valid_post_attrs)
      assert {:ok, %Post{} = post} = Content.update_post(post, @update_post_attrs)
      assert post.body == @update_post_attrs.body
      assert post.title == @update_post_attrs.title
    end

    @tag run: true
    test "update_post/2 with invalid data returns error changeset" do
      {:ok, post} = Fixture.post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_post(post, @invalid_post_attrs)
    end

    @tag run: true
    test "delete_post/1 deletes the post" do
      {:ok, post} = Fixture.post_fixture()
      assert {:ok, %Post{}} = Content.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_post!(post.id) end
    end

    @tag run: true
    test "change_post/1 returns a post changeset" do
      {:ok, post} = Fixture.post_fixture(@valid_post_attrs)
      assert %Ecto.Changeset{} = Content.change_post(post)
    end

    @tag run: true
    test "sorted_posts/0 returns sorted posts" do
      Fixture.posts_fixture()
      post_list = Content.list_posts()
      ids = Enum.map(post_list, fn post->
        post.id
      end)

      sort_order = Enum.shuffle(ids) |> Enum.join(",") 
      {:ok, post_order } = Content.save_posts_order(%{"order" => sort_order})
      
      sorted_post = Content.list_posts()
      assert Enum.map(sorted_post, &(&1.id)) |> Enum.join(",") == post_order.order
    end

    @tag run: true
    test "sorted_posts/0 update order and returns sorted posts" do
      Fixture.posts_fixture()
      post_list = Content.list_posts()
      ids = Enum.map(post_list, fn post->
        post.id
      end)

      sort_order = Enum.shuffle(ids) |> Enum.join(",") 
      {:ok, _post_order } = Content.save_posts_order(%{"order" => sort_order})
      _updated_sort_order = Enum.shuffle(ids) |> Enum.join(",")

      {:ok, post_order } = Content.save_posts_order(%{"order" => sort_order})
      
      sorted_post = Content.list_posts()
      assert Enum.map(sorted_post, &(&1.id)) |> Enum.join(",") == post_order.order
    end
  end

  describe "comments" do
    use LearnWebdevWithElixir.FixtureParams
    alias LearnWebdevWithElixir.Content.Post.Comment
    alias LearnWebdevWithElixir.{Content, Fixture}
    
    @tag run: true
    test "list_comments/0 returns all comments" do
      assert is_list(Content.list_comments())
    end

    @tag run: true
    test "get_comment!/1 returns the comment with given id" do
      {:ok, comment} = Fixture.comment_fixture(@valid_comment_attrs)
      assert Content.get_comment!(comment.id) == comment
    end

    @tag run: true
    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Fixture.comment_fixture(@valid_comment_attrs)
      assert comment.body == @valid_comment_attrs.body
    end

    @tag run: true
    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fixture.comment_fixture(@invalid_comment_attrs)
    end

    @tag run: true
    test "update_comment/2 with valid data updates the comment" do
      {:ok, comment} = Fixture.comment_fixture(@valid_comment_attrs)
      assert {:ok, %Comment{} = comment} = Content.update_comment(comment, @update_comment_attrs)
      assert comment.body == @update_comment_attrs.body
    end

    @tag run: true
    test "update_comment/2 with invalid data returns error changeset" do
      {:ok, comment} = Fixture.comment_fixture(@valid_comment_attrs)
      assert {:error, %Ecto.Changeset{}} = Content.update_comment(comment, @invalid_comment_attrs)
    end

    @tag run: true
    test "delete_comment/1 deletes the comment" do
      {:ok, comment} = Fixture.comment_fixture(@valid_comment_attrs)
      assert {:ok, %Comment{}} = Content.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Content.get_comment!(comment.id) end
    end

    @tag run: true
    test "change_comment/1 returns a comment changeset" do
      {:ok, comment} = Fixture.comment_fixture(@valid_comment_attrs)
      assert %Ecto.Changeset{} = Content.change_comment(comment)
    end
  end

  describe "pages" do
    use LearnWebdevWithElixir.FixtureParams
    alias LearnWebdevWithElixir.Content.Page
    alias LearnWebdevWithElixir.{Content, Fixture}

    @tag run: true
    test "list_pages/0 returns all pages" do
      assert is_list(Content.list_pages())
    end

    @tag run: true
    test "get_page!/1 returns the page with given id" do
      {:ok, page} = Fixture.page_fixture(@valid_page_attrs)
      assert Content.get_page!(page.id).id == page.id
    end

    @tag run: true
    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Content.create_page(@valid_page_attrs)
      assert page.body == @valid_page_attrs.body
      assert page.title == @valid_page_attrs.title
    end

    @tag run: true
    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_page(@invalid_page_attrs)
    end

    @tag run: true
    test "update_page/2 with valid data updates the page" do
      {:ok, page} = Fixture.page_fixture(@valid_page_attrs)
      assert {:ok, %Page{} = page} = Content.update_page(page, @update_page_attrs)
      assert page.body == @update_page_attrs.body
      assert page.title == @update_page_attrs.title
    end

    @tag run: true
    test "update_page/2 with invalid data returns error changeset" do
      {:ok, page} = Fixture.page_fixture(@valid_page_attrs)
      assert {:error, %Ecto.Changeset{}} = Content.update_page(page, @invalid_page_attrs)
    end

    @tag run: true
    test "delete_page/1 deletes the page" do
      {:ok, page} = Fixture.page_fixture(@valid_page_attrs)
      assert {:ok, %Page{}} = Content.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Content.get_page!(page.id) end
    end

    @tag run: true
    test "change_page/1 returns a page changeset" do
      {:ok, page} = Fixture.page_fixture(@valid_page_attrs)
      assert %Ecto.Changeset{} = Content.change_page(page)
    end
    
  end
end
