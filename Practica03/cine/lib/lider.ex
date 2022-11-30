defmodule Lider do
  def start(n_alumnos) do
    list = for _x <- 1..n_alumnos do
            caller = Alumno.start()
            Alumno.envia_mensaje(caller)
          end
    send(self(),{:vista_props,list})

    loop(n_alumnos)
  end

  defp loop(n_alumnos) do
    Alumno.recibe_propuesta()
    Process.sleep(1000)
    receive do
      {:prop_min,n,l} -> terminar(n,l,n_alumnos)
      _ -> loop(n_alumnos)
    end
  end
  def terminar(n,l,n_alumnos) do
    IO.puts("El total de procesos que participaron es #{inspect(n_alumnos)}")
    IO.puts("El acuerdo es #{inspect(n)}")
    l=Enum.filter(l,fn x-> x != true end)
    size = length(l)
    IO.puts("Numero de procesos que terminaron el algoritmo #{inspect(size)}")
  end
end
