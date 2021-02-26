defmodule Rocketpay.Users.Create do
  alias Ecto.Multi
  alias Rocketpay.{Repo, User,Account}

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      account_changeset(user.id)
      |> repo.insert()
    end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
      preload_data(repo, user)
    end)
    |> run_transaction()


    # params
    #   |> User.changeset()
    #   |> Repo.insert()
  end

  defp account_changeset(user_id) do
    %{user_id: user_id, balance: "0.00"}
    |> Account.changeset()
  end

  defp preload_data(_repo, user) do
    {:ok, Repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _reason, reason, _changes} -> {:error, reason}

      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
