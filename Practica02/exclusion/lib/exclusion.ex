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

    pan = Pan.start()
    cant_pan = Pan.crea_pan()

    alice = Alice.start()
    bob = Bob.start()
    Alice.envia_mensaje_alice(self(),:acquire1,[:acquire1])
    Bob.envia_mensaje_bob(self(),:acquire1,[:acquire1])
    estado_alice=Alice.recibeMensajes()
    estado_bob= Bob.recibeMensajes()
    cant_pan=Pan.loop(cant_pan)

    Bob.decide_bob(estado_bob,estado_alice)
    Process.sleep(1200)


    Alice.envia_mensaje_alice(self(),:acquire1,[:acquire1])
    Bob.envia_mensaje_bob(self(),:acquire1,[:acquire1])
    estado_alice=Alice.recibeMensajes()
    estado_bob= Bob.recibeMensajes()
    cant_pan=Pan.loop(cant_pan)

    Alice.decide_alice(estado_bob,estado_alice)
    Process.sleep(1200)

    hello()

  end
end
