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
    alice = Alice.start()
    bob = Bob.start()

    Alice.enviaMensaje(self(),:acquiere2,[:acquiere2])
    estado_bob= Bob.recibeMensajes()
    estado_alice=Alice.recibeMensajes()

    #hello()

  end
end
