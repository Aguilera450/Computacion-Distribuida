defmodule Alumno do

  def start do
    spawn(fn ->
      send(self(), {:prop, elige_numero()})
    end)
  end

  def envia_mensaje(caller) do
    #Probabilidad de fallar
    if Enum.random(1..4) == 3 do
      Process.exit(caller, :kill)
    else
      n=elige_numero()
      #IO.inspect(n)
      send(caller,n)
    end
  end

  def elige_numero do
    Enum.random(1..1000)
  end

  def recibe_propuesta do
    IO.inspect("Estoy esperando mensajes")
    receive do
      {:vista_props,list}-> Alumno.elige_min(list)
      {:prop,n} -> n
      {:prop_min,n,l} -> IO.puts("propuesta=#{inspect(l)}")
      _ -> IO.inspect("Alumno: Otro mensaje")
    end
    Process.sleep(100)
  end
  def elige_min(lista_prop) do
    l=Enum.sort(lista_prop, :asc)
    l=Enum.filter(l,fn x-> x != true end)
    IO.puts("v=#{inspect(l)}")
    tmp = List.first(l)
    send(self(),{:prop_min,tmp,l})
  end
end
