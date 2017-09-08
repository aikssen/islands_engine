defmodule IslandsEngine.Coordinate do
  @moduledoc false

  defstruct in_island: :none, guessed?: false
  
  # in order to use %Coordinate{}
  # instead of %IslandsEngine.Coordinate{}
  alias IslandsEngine.Coordinate

  # coord = Map.put(coord, :guessed?, true)

  def start_link() do
    Agent.start_link(fn -> %Coordinate{} end)
  end

  # Agent.get(agent PID, anonymous function)
  # coord = Agent.get(coordinate, fn state -> state end)
  # guessed = Agent.get(coordinate, fn state -> state.guessed? end)

  def guessed?(coordinate) do
    Agent.get(coordinate, fn state -> state.guessed? end)
  end

  def island(coordinate) do
    Agent.get(coordinate, fn state -> state.in_island end)
  end

  def in_island?(coordinate) do
    case island(coordinate) do
      :none -> false
      _     -> true
    end
  end

  def hit?(coordinate) do
    in_island?(coordinate) && guessed?(coordinate)
  end

  def guess(coordinate) do
    Agent.update(coordinate, fn state -> Map.put(state, :guessed?, true) end)
  end

  # e.g value = :my_island
  def set_in_island(coordinate, value) when is_atom value do
    Agent.update(coordinate, fn state -> Map.put(state, :in_island, value) end)
  end

end
