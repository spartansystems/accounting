defmodule Accounting.Assertions do
  import ExUnit.Assertions, only: [flunk: 1]

  @timeout 100

  def assert_registered_category(category) do
    receive do
      {:registered_category, ^category} -> true
    after
      @timeout ->
        flunk "Category '#{category}' was not registered."
    end
  end

  def assert_created_account(number) do
    receive do
      {:created_account, ^number} -> true
    after
      @timeout ->
        flunk "An account was not created with the number '#{number}'."
    end
  end

  def assert_received_money_with_line_item(from, date, line_item) do
    receive do
      {:received_money, ^from, ^date, ^line_item} -> true
    after
      @timeout ->
        flunk """
        Money was not received from '#{from}' on #{date} with the line item:

        #{inspect line_item}
        """
    end
  end

  def refute_received_money(from, date) do
    receive do
      {:received_money, ^from, ^date, _} ->
        flunk "Money was unexpectedly received."
    after
      @timeout -> true
    end
  end

  def assert_spent_money_with_line_item(to, date, line_item) do
    receive do
      {:spent_money, ^to, ^date, ^line_item} -> true
    after
      @timeout ->
        flunk """
        Money was not spent towards '#{to}' on #{date} with the line item:

        #{inspect line_item}
        """
    end
  end

  def refute_spent_money(to, date) do
    receive do
      {:spent_money, ^to, ^date, _} ->
        flunk "Money was unexpectedly spent."
    after
      @timeout -> true
    end
  end
end
