defmodule Pan do
  def hayPan? do
    n=Enum.random(0..10)
    if n > 0 do
      {:true,n}
    else
      {:false,n}
    end
  end
end
