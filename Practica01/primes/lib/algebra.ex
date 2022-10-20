defmodule Algebra do

  def is_prime?(n) do
    n == List.last(primes_to(n))
  end

  def primes_to(n) do
    do_primes(Enum.to_list(1..n))
  end

  def do_primes([]), do: []
  def do_primes([1 | xs]), do: do_primes(xs)
  def do_primes([prime | _] = sieve) do
    sieve =
      sieve
      |> Enum.filter((fn n -> rem(n, prime) != 0 end))
    [prime | do_primes(sieve)]
  end

end
