defmodule Alice do
  def start do
    spawn(fn -> send(self(),{:acquire1,[:acquire1]}) end)
  end

  def enviaMensaje(dest,tipo,mailbox) do
    case tipo do
      :acquiere1 -> send(dest,{:acquiere1,mailbox})
      :acquiere2 -> send(dest,{:acquiere2,mailbox})
      :release1 -> send(dest, {:release1,mailbox})
      :release2 -> send(dest, {:release2,mailbox})
    end
  end


  def recibeMensajes do
    IO.inspect("Alice espera mensaje")
    flag_b1=false
    flag_b2=false
    receive do
      # Verificar B1, si Alice ha recibido al menos un acquire1 y no ha recibido release1
      {:acquiere1, mailbox} -> if Enum.member?(mailbox,:release1) do
                                  IO.puts("VerificarB1, he recibido :release1 no se cumple B1")
                                else
                                  flag_b1=true
                                  IO.inspect("No he recibido :release1, se cumple B1")
                                  envia_banderas_alice(flag_b1,flag_b2)
                                end
      # Verificar B2, si Alice ha recibido al menos un acquire2 de Bob y no ha recibido release2
      {:acquiere2, mailbox}->if Enum.member?(mailbox,:release2) do
                            IO.puts("Verificar B2, he recibido :release2 no se cumple B2")
                            else
                              flag_b2=true
                              IO.inspect("No he recibido :release2, se cumple B2")
                              envia_banderas_alice(flag_b1,flag_b2)
                            end
      {[flag_a1,flag_a2]} -> IO.inspect("Recibi banderas Bob")
                            decide_alice(flag_a1,flag_a2,flag_b1,flag_b2)
      _ -> IO.inspect("Alice recibio otro mensaje")
    end
  end

  def envia_banderas_alice(flag_b1,flag_b2) do
    send(self(),{[flag_b1,flag_b2]})
  end

  def decide_alice(flag_a1,flag_a2,flag_b1,flag_b2) do
    IO.inspect("Alice decide que hacer")
  end

end
