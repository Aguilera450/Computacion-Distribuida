defmodule Bob do
  def start do
    spawn(fn -> send(self(),{:acquire1,[:acquire1]}) end)
  end

  def recibeMensajes do
    flag_b1=false
    flag_b2=false
    flag_a1=false
    flag_a2=false
    receive do

      # Recibo :acquiere1 desde Alice verificar A2, es decir, si ha recibido release1
      {:acquiere2, mailbox} -> if Enum.member?(mailbox,:release2) do
        IO.puts("VerificarA2, he recibido :release2")
        send(self(),{:release2,mailbox++[:release2]})
      else
        IO.inspect("No he recibido :release2")
        flag_a2=true
        send(self(),{:acquiere2,mailbox++[:acquiere2]})
      end

      # Verificar A1, si Bob ha recibido al menos un acquire1 y no ha recibido release1
      {:acquiere1, mailbox} -> if Enum.member?(mailbox,:release1) do
        IO.puts("VerificarA1, he recibido :release1")
      else
        IO.inspect("No he recibido :release1")
        flag_a1=true
        send(self(),{:acquiere2,mailbox++[:acquiere2]})
      end
      _ -> IO.inspect("ajBob")
    end

  end
end
