defmodule Pan do
  def start do
    spawn(fn ->  send(self(),n=Enum.random(0..10)) end)
  end
  def hayPan? do
    n=Enum.random(0..10)
    if n > 0 do
      :true
    else
      :false
    end
  end
end
