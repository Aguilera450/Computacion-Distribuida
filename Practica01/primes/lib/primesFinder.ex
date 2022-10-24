defmodule PrimesFinder do
  def range(upper_bound) do
    start_time = :os.system_time(:millisecond)
    primes = Server.start(10,upper_bound)
    finish_time = :os.system_time(:millisecond)
    write_primes(primes)
    diff_time = finish_time - start_time
    time_text = "Inicio: "<>Integer.to_string(start_time)<>"  Final: "<>Integer.to_string(finish_time)<>" Diferencia: "<>Integer.to_string(diff_time)<>"\n"
  end

  def write_time(x) do
    file_time = File.open!("times.txt",[:write])
    time = 100..x
    |> Enum.map(fn n -> range(n) end)

    time = List.to_string(time)
    IO.write(file_time,inspect(time, pretty: true, limit: :infinity))
    File.close(file_time)
  end
  def write_primes(primes) do
    file_primes = File.open!("primes.txt",[:write])
    IO.write(file_primes,inspect(primes, pretty: true, limit: :infinity))
    File.close(file_primes)
  end

  def dispenser(x) do
    :ok
  end

  def manage(upper_bound) do
    block = div(upper_bound, 10)
    pid_leader= Process.spawn((fn  -> 2 end), [:link])
    i=0
    0..9
    |> Enum.to_list()
    |> Enum.map(fn _ -> i=i+1 end)
    |> Enum.map(fn i -> Worker.start((i * block) + 1, min((i + 1) * block, upper_bound)) end)
    |> Enum.map(fn x -> if Process.info(x)[:status] == :waiting do is_list(x) end end)
    #|> Enum.map(fn _ -> Worker.get_result end)
    #|> Enum.concat()
    #|> Enum.sort()
  end
end
