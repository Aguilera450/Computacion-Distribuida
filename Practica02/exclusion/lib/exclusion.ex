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
    bob = Bob.start()
    alice = Alice.start()

    Alice.enviaMensaje(self(),:acquire1,[:acquire1])
    estado_bob= Bob.recibeMensajes()
    estado_alice=Alice.recibeMensajes()

    #hello()

  end
end
