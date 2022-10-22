defmodule PrimesFinder do
  def range(upper_bound) do
    start_time = :os.system_time(:millisecond)
    primes = Server.start(10,upper_bound)
    finish_time = :os.system_time(:millisecond)

    diff_time = finish_time - start_time
    time_text = "\nInicio: "<>Integer.to_string(start_time)<>"  Final: "<>Integer.to_string(finish_time)<>"  Diferencia: "<>Integer.to_string(diff_time)
  end

  def write_time do
    file_time = File.open!("times.txt",[:write])
    time = 100..1000
    |> Enum.map(fn n -> range(n) end)

    time = List.to_charlist(time)
    IO.write(file_time,time)
  end

  def dispenser(upper_bound) do
    lider = Process.spawn((fn x -> 2 end), [:link])
    manage(upper_bound)                             
  end

  def manage(upper_bound) do
    block = div(upper_bound, 10)
    0..9
    |> Enum.to_list()
    |> Enum.map(fn wid -> Worker.start((wid * block) + 1, min((wid + 1) * block, upper_bound)) end)
    |> Enum.map(fn x -> Process.info(x) end)
  end
end
  