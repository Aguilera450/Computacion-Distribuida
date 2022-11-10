defmodule Bob do
  def start do
    IO.inspect("Bob llego a casa")
    spawn(fn -> send(self(),{:acquire1,[:acquire1]}) end)
  end

  def envia_mensaje_bob(dest,tipo,mailbox) do
    case tipo do
      :acquire1 -> send(dest,{:acquire1,mailbox})
      :acquire2 -> send(dest,{:acquire2,mailbox})
      :release1 -> send(dest, {:release1,mailbox})
      :release2 -> send(dest, {:release2,mailbox})
    end
  end

  def recibeMensajes do
    IO.inspect("Bob espera mensaje")
    flag_a1=false
    flag_a2=false
    receive do
      # Verificar A1, si Bob ha recibido al menos un acquire1 y no ha recibido release1
      {:acquire1, mailbox} -> if Enum.member?(mailbox,:release1) do
        IO.puts("Bob dice recibi :acquire1 y he recibido :release1. no se cumple A1")
        [flag_a1,flag_a2,mailbox]
      else
        IO.inspect("Bob dice recibi :acquire1 y no he recibido :release1, se cumple A1")
        flag_a1=true
        [flag_a1,flag_a2,mailbox]
      end

      # Verificar A2, es decir, si ha recibido release1
      {:acquire2, mailbox} -> if Enum.member?(mailbox,:release2) do
        IO.puts("Bob dice recibi :acquire2 y he recibido :release2, no se cumple A2")
        [flag_a1,flag_a2]
      else
        flag_a2=true
        IO.inspect("Bob dice recibi :acquire2 y no he recibido :release2, se cumple A2")
        [flag_a1,flag_a2,mailbox]
      end

      {:release1,mailbox}-> if Enum.member?(mailbox,:acquiere1) do
        IO.puts("Bob dice he recibido :release1 despues de :acquire1 así que no se cumple A1")
        [flag_a1,flag_a2,mailbox]
      else
        IO.inspect("Bob dice no he recibido :acquiere1, pero si :release1")
        [flag_a1,flag_a2,mailbox]
      end

      {:release2, mailbox} -> if Enum.member?(mailbox,:acquiere2) do
          IO.puts("Bob dice he recibido :release2 despues de :acquire2 así que no se cumple A2")
          [flag_a1,flag_a2,mailbox]
        else
          IO.inspect("Bob dice no he recibido :acquiere1, pero si :release1")
          [flag_a1,flag_a2,mailbox]
        end
      _ -> [false,false,[]]#IO.inspect("Bob dice recibi otro mensaje")
    end
  end

  def decide_bob(bob_flags,alice_flags) do
    if bob_flags != :ok and alice_flags != :ok do

      flag_a1=List.first(bob_flags)
      bob_flags=List.delete_at(bob_flags,0)
      flag_a2=List.first(bob_flags)
      bob_mailbox=List.last(bob_flags)

      flag_b1=List.first(alice_flags)
      alice_flags=List.delete_at(alice_flags,0)
      flag_b2=List.first(alice_flags)
      alice_mailbox=List.last(alice_flags)

      decide_bob2(flag_a1,flag_a2,flag_b1,flag_b2,bob_mailbox)
    end
  end

  def decide_bob2(flag_a1,flag_a2,flag_b1,flag_b2, mailbox) do
    IO.inspect("Bob decide que hacer")
    if flag_a2 do
      send(self(),{:release2,mailbox++[:release2]})
    else
      send(self(),{:acquire2,mailbox++[:acquire2]})
    end
    if flag_a1 do
      if (flag_a2 and !flag_b2) or (!flag_a2 and flag_b2) do
        Process.sleep(1000)
      end
    end
    pregunta_pan()

    send(self(),{:release1,mailbox++[:release1]})
  end

  def pregunta_pan() do
    receive do
      {:pan,cant} -> if !(Pan.hay_pan?(cant)) do
          IO.inspect("Bob dice no hay pan, voy a comprar")
          send(self(),:llena)
          send(self(),{:release1,[]})
      else
        IO.inspect("Todavia hay "<>Integer.to_string(cant)<>" rebanadas de pan")
        send(self(),{:release1,[]})
      end
    end
  end

end
