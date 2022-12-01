defmodule Alumno do

  def start do
    spawn(fn ->
      send(self(), {:prop, elige_numero()})
    end)
  end

  def envia_mensaje(caller,cont) do
    n=elige_numero()
    cont=cont+1
    #Probabilidad de fallar
    if Enum.random(1..10) == 3 do
      IO.puts("El proceso #{inspect(caller)} propone #{inspect(n)}, antes de fallar")
      Process.exit(caller, :kill)
    else
      IO.puts("El proceso #{inspect(caller)} propone #{inspect(n)}, #{cont} veces")
      send(caller,n)
    end
  end

  def elige_numero do
    Enum.random(1..1000)
  end

  def recibe_propuesta do
    IO.inspect("Estoy esperando mensajes")
    receive do
      {:prop,n} -> IO.puts("Se recibe la propuesta #{n}")
                    n
      {:vista_props,list}-> Alumno.elige_min(list)
      n->n
    end
    Process.sleep(1000)
  end
  def elige_min(lista_prop) do
    l=Enum.sort(lista_prop, :asc)
    l=Enum.filter(l,fn x-> x != true end)
    IO.puts("v=#{inspect(l)}")
    tmp = List.first(l)

    send(self(),{:prop_min,tmp,l})
  end

  def envia_mensaje_n(n,cont) do
    caller=self()
    IO.puts("El proceso propone #{inspect(n)}, #{cont} veces")
    send(caller,n)
    Process.sleep(1000)
    n
  end
end
