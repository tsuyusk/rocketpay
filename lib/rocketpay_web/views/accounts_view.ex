defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: Transaction

  def render("update.json", %{account: %Account{} = account}) do
    %{
      id: account.id,
      balance: account.balance
    }
  end

  def render("transaction.json", %{transaction: %Transaction{} = transaction}) do
    %{
      from_account: %{
        id: transaction.from_account.id,
        balance: transaction.from_account.balance,
      },
      to_account: %{
        id: transaction.to_account.id,
        balance: transaction.to_account.balance,
      }
    }
  end
end
