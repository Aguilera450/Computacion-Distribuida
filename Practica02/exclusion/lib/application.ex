defmodule Exclusion.Application do
  use Application

  def start(_, _) do
    Exclusion.hello()
  end
end
