defmodule Bob do
  def start do
    spawn(fn -> send(self(),{:acquire1,[:acquire1]}) end)
  end

  def recibeMensajes do
    IO.inspect("Bob espera mensaje")
    flag_a1=false
    flag_a2=false
    receive do
      # Verificar A1, si Bob ha recibido al menos un acquire1 y no ha recibido release1
      {:acquire1, mailbox} -> if Enum.member?(mailbox,:release1) do
        IO.puts("Recibi :acquire1 y he recibido :release1. no se cumple A1")
      else
        IO.inspect("Recibi :acquire1 y no he recibido :release1, se cumple A1")
        flag_a1=true
        envia_banderas_bob(flag_a1,flag_a2,mailbox)
      end

      # Verificar A2, es decir, si ha recibido release1
      {:acquire2, mailbox} -> if Enum.member?(mailbox,:release2) do
        IO.puts("Recibi :acquire2 y he recibido :release2, no se cumple A2")
      else
        flag_a2=true
        IO.inspect("Recibi :acquire2 y no he recibido :release2, se cumple A2")
        envia_banderas_bob(flag_a1,flag_a2,mailbox)
      end
      {[flag_b1,flag_b2],mailbox} -> IO.inspect("Recibi banderas Alice")
      _ -> IO.inspect("Bob recibio otro mensaje")
    end
  end

  def envia_banderas_bob(flag_a1,flag_a2,mailbox) do
    send(self(),{[flag_a1,flag_a2],mailbox})
  end


  def decide_bob(flag_a1,flag_a2,flag_b1,flag_b2,mailbox) do
    IO.inspect("Bob decide que hacer")
  end
end
