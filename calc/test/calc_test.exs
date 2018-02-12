defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  #Following tests make sure all other helper functions are tested.
  test "eval function - exp without spaces" do
    assert Calc.eval("(9*5)-10+(5*2)") == 45
  end

  test "eval function - exp with spaces" do
    assert Calc.eval("56 + (8 - 6) * 0.8") == 57.6
  end

  test "eval function - exp with nested paranthesis" do
  	assert Calc.eval("(2 + 8 * (9 / 3))") == 26
  end
end
