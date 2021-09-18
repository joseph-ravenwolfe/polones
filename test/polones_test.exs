defmodule PolonesTest do
  use ExUnit.Case
  doctest Polones

  test "starts the calculator" do
    assert ExUnit.CaptureIO.capture_io(fn -> Polones.start() end) == "Calculator started...\n"
  end
end
