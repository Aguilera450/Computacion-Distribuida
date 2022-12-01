defmodule Lider do
  def start(n_alumnos) do
    cont=0
    list=for _x <- 1..n_alumnos do
      caller = Alumno.start()
      Alumno.envia_mensaje(caller,cont)
      end

    list=Enum.filter(list,fn x-> x != true end)
    send(self(),{:vista_props,list})
    loop(n_alumnos)
  end

  defp loop(n_alumnos) do
    Alumno.recibe_propuesta()
    receive do
      {:prop_min,n,l} -> terminar(n,l,n_alumnos)
    end
    Process.sleep(1000)
  end
  def terminar(n,l,n_alumnos) do
    if length(l) >= n_alumnos do
      IO.puts("No es posible llegar a un consenso")
    else
      anuncia_decision(l)
      Alumno.recibe_propuesta()
      IO.puts("El total de procesos que participaron es #{inspect(n_alumnos)}")
      IO.puts("El acuerdo es #{inspect(n)}")
      l=Enum.filter(l,fn x-> x != true end)
      size = length(l)
      IO.puts("Numero de procesos que terminaron el algoritmo #{inspect(size)}")
    end
  end

  def anuncia_decision(l) do
    cont=1
    l = for i <- l do
              Alumno.envia_mensaje_n(i,cont+1)
            end
    l=Enum.filter(l,fn x-> x != true end)

    send(self(),{:vista_props,l})
  end

end
