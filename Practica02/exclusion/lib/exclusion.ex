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
    Bob.recibeMensajes()



    #hello()

  end
end
