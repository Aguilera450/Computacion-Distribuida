defmodule Alice do
  def start do
    spawn(fn -> send(self(),{:acquire1,[:acquire1]}) end)
  end

  def enviaMensaje(dest,tipo,mailbox) do
    case tipo do
      :acquire1 -> send(dest,{:acquire1,mailbox})
      :acquire2 -> send(dest,{:acquire2,mailbox})
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
      {:acquire1, mailbox} -> if Enum.member?(mailbox,:release1) do
                                  IO.puts("VerificarB1, he recibido :release1 no se cumple B1")
                                else
                                  flag_b1=true
                                  IO.inspect("No he recibido :release1, se cumple B1")
                                  envia_banderas_alice(flag_b1,flag_b2,mailbox)
                                end
      # Verificar B2, si Alice ha recibido al menos un acquire2 de Bob y no ha recibido release2
      {:acquire2, mailbox}->if Enum.member?(mailbox,:release2) do
                            IO.puts("Verificar B2, he recibido :release2 no se cumple B2")
                            else
                              flag_b2=true
                              IO.inspect("No he recibido :release2, se cumple B2")
                              envia_banderas_alice(flag_b1,flag_b2,mailbox)
                            end
      {[flag_a1,flag_a2],mailbox} -> IO.inspect("Recibi banderas Bob")
                            decide_alice(flag_a1,flag_a2,flag_b1,flag_b2,mailbox)
      _ -> IO.inspect("Alice recibio otro mensaje")
    end
  end

  def envia_banderas_alice(flag_b1,flag_b2,mailbox) do
    send(self(),{[flag_b1,flag_b2],mailbox})
  end

  def decide_alice(flag_a1,flag_a2,flag_b1,flag_b2, mailbox) do
    IO.inspect("Alice decide que hacer")
    if flag_b2 do
      send(self(),{:acquire2,mailbox++[:acquire2]})
    else
      send(self(),{:release2,mailbox++[:release2]})
    end
    end
  end

end
