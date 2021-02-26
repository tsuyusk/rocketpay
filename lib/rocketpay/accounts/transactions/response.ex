defmodule Rocketpay.Accounts.Transactions.Response do
  alias Rocketpay.Account

  defstruct [:from_account, :to_account]

  def build(%Account{} = from_account, %Account{} = to_account) do
    # Returns the name of the module, therefore it will return TransactionsResponse struct
    # __MODULE__ = Rocketpay.Accounts.Transactions.Response
    %__MODULE__{
      from_account: from_account,
      to_account: to_account,
    }
  end
end
