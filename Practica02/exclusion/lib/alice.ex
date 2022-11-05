defmodule Alice do
  def start do
    mailbox =[:acquire1]
    send(self(),{:acquire1,:alice,mailbox})
    Bob.start()
  end
end
