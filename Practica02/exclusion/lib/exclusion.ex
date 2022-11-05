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
    :world
  end
  def hay_pan? do
    rand=Enum.random(100)
    rand < 0
  end

  def loop do #Alice
    send(self(),:acquire1)
    receive do
      :acquire2 ->  acq2() #B2
      {:acquire1} -> IO.inspect("Acq1")
    end
    loop()
  end

  def acq2 do
    IO.inspect("No ha recibido release2")
    receive do
      :release2 -> if hay_Pan? do IO.inspect("Hay pan") else IO.inspect("Voy por pan") end
      _ -> send(self(),:acquire2)
    end

  end

end
