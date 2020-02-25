defmodule LearnWebdevWithElixir.Policies do
  # turn this module into an enforcement plug
  use PolicyWonk.Enforce

  def policy(assigns, {:admin_permission, perms}) when is_list(perms) do
    case assigns[:current_user] do
      nil ->
        :current_user

      user ->
        case user.permissions do
          # Fail. No permissions
          nil ->
            {:error, :admin_permission}

          user_perms ->
            Enum.all?(perms, &Enum.member?(user_perms, to_string(&1)))
            |> case do
              # Success.
              true -> :ok
              # Fail. Permission missing
              false -> {:error, :admin_permission}
            end
        end
    end
  end

  def policy(assigns, {:admin_permission, one_perm}),
    do: policy(assigns, {:admin_permission, [one_perm]})

  def policy_error(conn, :admin_permission) do
    LearnWebdevWithElixir.ErrorHandlers.unauthenticated(conn, "Unauthorized")
  end
end
