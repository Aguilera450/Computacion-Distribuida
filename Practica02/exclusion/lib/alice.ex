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
    flag_b1=false
    flag_b2=false
    flag_a1=false
    flag_a2=false
    receive do
      {:acquiere1, mailbox} -> IO.inspect("A1")
      _ -> IO.inspect("aj")
    end
  end

end
