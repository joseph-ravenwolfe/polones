defmodule PolonesTest do
  use ExUnit.Case
  doctest Polones

  import Polones.StringAdapter

  describe "Integration Tests" do
    test "sums 5 and 8" do
      ~a(5)
      ~a(8)
      ~a(+)
      assert ~a() == 13
    end

    test "multiplies 2 by 3 and adds 5" do
      ~a(-3)
      ~a(-2)
      ~a(*)
      assert ~a() == 6
      ~a(5)
      ~a(+)
      assert ~a() == 11
    end

    test "sums 3 with 9 and multiplies by 2" do
      ~a(2)
      ~a(9)
      ~a(3)
      ~a(+)
      assert ~a() == 12
      ~a(*)
      assert ~a() == 24
    end

    test "subtracts 20 by 13 and divides by 2" do
      ~a(20)
      ~a(13)
      ~a(-)
      assert ~a() == 7
      ~a(2)
      ~a(/)
      assert ~a() == 3.5
    end

    test "ignores unrecognized input" do
      ~a(2)
      ~a(noop)
      ~a(2)
      ~a(+)
      assert ~a() == 4
    end

    test "performs several shorthand calculations" do
      ~a(2 4 *)
      assert ~a() == 8
    end

    test "rewinds through steps" do
      ~a(2)
      ~a(4)
      ~a(rw)
      ~a(7)
      ~a(*)
      assert ~a() == 14
    end

    test "fast forwards through steps" do
      ~a(2)
      ~a(4)
      ~a(3)
      ~a(rw)
      ~a(rw)
      ~a(ff)
      ~a(+)
      ~a(2)
      ~a(*)
      assert ~a() == 12
    end

    test "clears history" do
      ~a(2)
      ~a(4)
      ~a(3)
      ~a(c)
      assert ~a() == 0
    end
  end
end
