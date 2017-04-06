defmodule Accounting.Adapter do
  @callback start_link() :: Supervisor.on_start
  @callback register_categories([atom], timeout) :: :ok | {:error, any}
  @callback create_account(String.t, String.t, timeout) :: :ok | {:error, any}
  @callback receive_money(String.t, Date.t, [Accounting.LineItem.t], timeout) :: :ok | {:error, any}
  @callback spend_money(String.t, Date.t, [Accounting.LineItem.t], timeout) :: :ok | {:error, any}
  @callback fetch_account_transactions(String.t, timeout) :: {:ok, [Accounting.AccountTransaction.t]} | {:error, any}
end
