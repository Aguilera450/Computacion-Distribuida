defmodule Algebra do
  def is_prime?(n) when n > 1 do
    n == List.last(primes_to(n))
  end

  def primes_to(n) do
    do_primes(Enum.to_list(1..n))
  end

  defp do_primes([]), do: []
  defp do_primes([1 | xs]), do: do_primes(xs)

  #defp do_primes([prime | _] = sieve) do
  defp do_primes(n) do
    #sieve =
      #sieve
      #|> Enum.filter(fn n -> rem(n,prime) != 0 end,
    #[prime | do_primes(sieve)])
    sieve = aux_sieve(Map.new(Enum.to_list(1..n), fn x -> {x, true} end), 2, n)
    Enum.filter(Map.keys(sieve), fn x -> Map.get(sieve, x) end)
  end

  defp aux_sieve(sieve, i, n) do
    cond do
      i > n -> sieve
      Map.get(sieve, i) -> aux_sieve(false_index(sieve, i, 2, n), (i+1), n)
      true -> aux_sieve(sieve, (i+1), n)
    end
  end

  defp false_index(sieve, i, j, n) do
    if i*j > n do
      sieve
    else
      false_index(Map.put(sieve, i*j, false), i, (j+1), n)
    end
  end


end
