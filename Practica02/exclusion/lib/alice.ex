defmodule Alice do
  def start do
    IO.inspect("Alice llego a casa")
    spawn(fn -> send(self(),{:acquire1,[:acquire1]}) end)
  end

  def envia_mensaje_alice(dest,tipo,mailbox) do
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
                                  IO.puts("Alice dice he recibido :release1 no se cumple B1")
                                  [flag_b1,flag_b2,mailbox]
                                else
                                  flag_b1=true
                                  IO.inspect("Alice dice no he recibido :release1, se cumple B1")
                                  [flag_b1,flag_b2,mailbox]
                                end
      # Verificar B2, si Alice ha recibido al menos un acquire2 de Bob y no ha recibido release2
      {:acquire2, mailbox}->if Enum.member?(mailbox,:release2) do
                              IO.puts("Alice dice he recibido :release2 no se cumple B2")
                              [flag_b1,flag_b2,mailbox]
                            else
                              flag_b2=true
                              IO.inspect("Alice dice no he recibido :release2, se cumple B2")
                              [flag_b1,flag_b2,mailbox]
                            end
      {:release1,mailbox}-> if Enum.member?(mailbox,:acquiere1) do
                            IO.puts("Alice dice he recibido :release1 despues de :acquire1 así que no se cumple B1")
                            [flag_b1,flag_b2,mailbox]
                          else
                            IO.inspect("Alice dice no he recibido :acquiere1, pero si :release1")
                            [flag_b1,flag_b2,mailbox]
                          end
      {:release2, mailbox} -> if Enum.member?(mailbox,:acquiere2) do
                              IO.puts("Alice dice he recibido :release2 despues de :acquire2 así que no se cumple B2")
                              [flag_b1,flag_b2,mailbox]
                            else
                              IO.inspect("Alice dice no he recibido :acquiere1, pero si :release1")
                              [flag_b1,flag_b2,mailbox]
                            end
      _ -> [false,false,[]]#IO.inspect("Alice recibio otro mensaje")
    end
  end

  def decide_alice2(flag_a1,flag_a2,flag_b1,flag_b2, mailbox) do
    IO.inspect("Alice decide que hacer")
    if flag_b2 do
      send(self(),{:acquire2,mailbox++[:acquire2]})
    else
      send(self(),{:release2,mailbox++[:release2]})
    end
    if flag_b1 do
      if (flag_a2 and flag_a2) or (!flag_a2 and !flag_b2) do
        Process.sleep(1000)
      end
    end
    pregunta_pan()

    send(self(),{:release1,mailbox++[:release1]})
  end

  def pregunta_pan() do
    receive do
      {:pan,cant} -> if !(Pan.hay_pan?(cant)) do
          IO.inspect("Alice dice no hay pan, voy a comprar")
          send(self(),:llena)
          send(self(),{:release1,[]})
      else
        IO.inspect("Todavia hay "<>Integer.to_string(cant)<>" rebanadas de pan")
        send(self(),{:release1,[]})
      end
    end
  end

  def decide_alice(bob_flags,alice_flags) do
    flag_a1=List.first(bob_flags)
    bob_flags=List.delete_at(bob_flags,0)
    flag_a2=List.first(bob_flags)
    bob_mailbox=List.last(bob_flags)

    flag_b1=List.first(alice_flags)
    alice_flags=List.delete_at(alice_flags,0)
    flag_b2=List.first(alice_flags)
    alice_mailbox=List.last(alice_flags)

    decide_alice2(flag_a1,flag_a2,flag_b1,flag_b2,alice_mailbox)
  end
end
