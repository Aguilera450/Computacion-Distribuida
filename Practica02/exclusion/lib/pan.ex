defmodule Pan do
  def start do
    spawn(fn ->  send(self(),{:pan, Enum.random(0..20)}) end)
  end
  def hay_pan?(n) do
    n > 0
  end

  def crea_pan do
    Enum.random(0..10)
  end

  def loop(cant_pan) do
    send(self(),{:pan,cant_pan})
    Process.sleep(1000)
    receive do
      {:pan,n} -> send(self(),{:pan, (cant_pan-1)})
      {:llena} -> loop(20)
    end
    cant_pan
  end
end
