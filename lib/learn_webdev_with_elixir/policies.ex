defmodule LearnWebdevWithElixir.Policies do
  # turn this module into an enforcement plug
  use PolicyWonk.Enforce
  alias LearnWebdevWithElixir.Accounts.User


  @doc """
    Check admin permissions for a logged in user
  """
  def policy(assigns, {:admin_permission, perms}) when is_list(perms) do
    with %User{} = user <- assigns[:current_user],
          [_|_] = user_perms <- user.permissions,
          true <- Enum.all?(perms, &Enum.member?(user_perms, to_string(&1))) do
          :ok
    else
        nil -> 
          {:error, :admin_permission}
        false -> 
          {:error, :admin_permission}
    end  
  end

  def policy(assigns, {:admin_permission, one_perm}),
    do: policy(assigns, {:admin_permission, [one_perm]})

  def policy_error(conn, :admin_permission) do
    LearnWebdevWithElixir.ErrorHandlers.unauthenticated(conn, "Unauthorized")
  end
end
