defmodule Exclusion do
  @moduledoc """
  Documentation for `Exclusion`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Exclusion.hello()
      :world

  """
  def hello do
    Alice.start()
    Bob.start()
  end
end
