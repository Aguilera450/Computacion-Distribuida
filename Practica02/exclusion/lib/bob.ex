defmodule Bob do
  def start do
    mailbox =[:acquire1]
    send(self(),{:acquire1,:bob,mailbox})
    loop()
  end
  def loop do
    IO.inspect("ENtro a loop")
    receive do
      # Si no A2 envio acquiere2
      {:acquire2,:bob,mailbox} -> IO.inspect("BOon")
      # Recibio desde alice acquire
      {:acquire1,:alice,mailbox} -> if (!flush()) do send(self(),{:acquiere2,:bob, mailbox++[:acquire2]}) end #IO.puts("Recibo mensaje de ALice")
      _ -> IO.inspect("Estoy en loop")
    end

    #flush()
    loop()
  end

  def flush do
    receive do
      {_,:acquire1,mailbox} -> Enum.each(mailbox, &verificarA2/1)
      _ -> IO.inspect("Estoy en flush")
    end
  end

  def verificarA2(x) do
    x==:release1
  end
end
