defmodule DayOneSolution do

  def solve(input) do
    moves = String.split(input, ", ")
    position = {0, 0}
    rotation = {0, 1}  # initially facing north

    {final_position, _, _} = Enum.reduce(moves, {position, rotation, MapSet.new()},
      fn(move, {position, rotation, visited}) ->
        advance(move, {position, rotation, visited})
      end)

    final_position
  end

  defp advance(move, {position, rotation, visited}) do
    letter = String.at(move, 0)
    steps = String.slice(move, 1, String.length(move)) |> String.to_integer

    new_rotation = get_new_rotation(letter, rotation)

    # Insted of multiplication
    {new_position, new_visited, _rotation} = Enum.reduce(1..steps, {position, visited, new_rotation},
      fn(step_no, {position, visited, rotation}) ->
        walk_through_intermediate_steps(step_no, {position, visited, rotation})
      end)

    {new_position, new_rotation, new_visited}
  end

  defp walk_through_intermediate_steps(_step_no, {position, visited, rotation}) do
    another_position = {elem(position, 0) + elem(rotation, 0),
                        elem(position, 1) + elem(rotation, 1)}

    case MapSet.member?(visited, another_position) do
      true ->
        IO.inspect("already been there! #{elem(another_position, 0)}, #{elem(another_position, 1)}")
        IO.inspect(abs(elem(another_position, 0)) + abs(elem(another_position, 1)))
        _ ->
          "I dont need this"
    end

    new_visited = MapSet.put(visited, another_position)

    {another_position, new_visited, rotation}
  end

  defp get_new_rotation(letter, rotation) do
    case {letter, rotation} do

      {"L", {-1, 0}} ->
        {0, -1}
      {"L", {0, -1}} ->
        {1, 0}
      {"L", {1, 0}} ->
        {0, 1}
      {"L", {0, 1}} ->
        {-1, 0}

      {"R", {1, 0}} ->
        {0, -1}
      {"R", {0, -1}} ->
        {-1, 0}
      {"R", {-1, 0}} ->
        {0, 1}
      {"R", {0, 1}} ->
        {1, 0}
    end
  end
end

test_input_first = "R2, L3"
test_input_second = "R2, R2, R2"
test_input_third = "R5, L5, R5, R3"

test_input_fourth = "R8, R4, R4, R8"

task_input = "L1, R3, R1, L5, L2, L5, R4, L2, R2, R2, L2, R1, L5, R3, L4, L1, L2, R3, R5, L2, R5, L1, R2, L5, R4, R2, R2, L1, L1, R1, L3, L1, R1, L3, R5, R3, R3, L4, R4, L2, L4, R1, R1, L193, R2, L1, R54, R1, L1, R71, L4, R3, R191, R3, R2, L4, R3, R2, L2, L4, L5, R4, R1, L2, L2, L3, L2, L1, R4, R1, R5, R3, L5, R3, R4, L2, R3, L1, L3, L3, L5, L1, L3, L3, L1, R3, L3, L2, R1, L3, L1, R5, R4, R3, R2, R3, L1, L2, R4, L3, R1, L1, L1, R5, R2, R4, R5, L1, L1, R1, L2, L4, R3, L1, L3, R5, R4, R3, R3, L2, R2, L1, R4, R2, L3, L4, L2, R2, R2, L4, R3, R5, L2, R2, R4, R5, L2, L3, L2, R5, L4, L2, R3, L5, R2, L1, R1, R3, R3, L5, L2, L2, R5"

final_position = DayOneSolution.solve(task_input)
IO.inspect(final_position)
IO.inspect(abs(elem(final_position, 0)) + abs(elem(final_position, 1)))
