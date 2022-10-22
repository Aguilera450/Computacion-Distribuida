defmodule PrimesFinder do
  def range(upper_bound) do
    start_time = :os.system_time(:millisecond)
    primes = Server.start(10,upper_bound)
    finish_time = :os.system_time(:millisecond)

    write_primes(primes)
    write_time(start_time,finish_time)
  end

  def write_primes(primes) do
    file_primes = File.open!("primes.txt",[:write])
    IO.write(file_primes,inspect(primes, pretty: true, limit: :infinity))
    File.close(file_primes)
  end

  def write_time(start_time,finish_time) do
    file_time = File.open!("times.txt",[:write])
    diff_time = start_time-finish_time
    time_text = "Inicio: "<>Integer.to_string(start_time)<>"  Final: "<>Integer.to_string(finish_time)<>"  Diferencia: "<>Integer.to_string(diff_time)

    IO.binwrite(file_time,time_text)
  end
end
