defmodule Algebra do
  def is_prime?(n) when n > 1 do
    n == List.last(primes_to(n))
  end


  def primes_to(n) do
    do_primes(Enum.to_List(1..n))
  end

  defp do_primes([]), do : []
  defp do_primes([1 | xs]), do: do_primes(xs)

  defp do_primes([prime | _]) = sieve) do
    sieve =
      sieve
      |> Enum.filter(fn n -> rem(n,prime) != 0 )
    [prime | do_primes(sieve)]
  end
end
