defmodule Bob do
  def start do
    send(self(),:acquire2)
  end
end
