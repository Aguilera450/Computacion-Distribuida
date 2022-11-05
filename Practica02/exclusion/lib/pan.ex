defmodule Pan do
  def hayPan? do
    n=Enum.random(100)
    if n > 0 do
      :true
    end
    :false
  end
end
