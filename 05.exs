defmodule DayFiveSolution do
  @lower_bound 0
  @upper_bound 1_000_000_000

  def solve(input) do
    get_hashed_stream(input)
    |> Stream.map(fn(filtered) ->
      String.at(filtered, 5)
    end)
    |> Enum.take(8)
    |> Enum.join()
  end

  defp get_hashed_stream(input) do
    Stream.map(@lower_bound..@upper_bound, fn(next_number) ->
      :crypto.hash(:md5, "#{input}#{next_number}")
      |> Base.encode16()
    end)
    |> Stream.filter(fn(encoded_and_hashed) ->
      encoded_and_hashed |>
      String.slice(0, 5) == "00000"
    end)
  end

  def solve_second_part(input) do
    get_hashed_stream(input)
    |> Stream.map(fn(filtered) ->
      position = String.at(filtered, 5)
      character = String.at(filtered, 6)
      {position, character}
    end)
    |> Stream.filter(fn({position, _character}) ->
      case Integer.parse(position) do
        :error ->
          false
        {correct_number, _} ->
          correct_number <= 7
      end
    end)
    |> Enum.reduce_while([], fn({position, character}, acc) ->
      case length(acc) do
        8 ->
          {:halt, acc}
        _ ->
          case Enum.find(acc, false, fn({saved_position, _char}) -> saved_position == position end) do
            false ->
              {:cont, [{position, character} | acc]}
            _ ->
              {:cont, acc}
          end
      end
    end)
    |> Enum.reduce([0, 0, 0, 0, 0, 0, 0, 0], fn({position, character}, acc) ->
      List.replace_at(acc, String.to_integer(position), character)
    end)
    |> Enum.join()
  end
end

IO.inspect(DayFiveSolution.solve("abc"))
IO.inspect(DayFiveSolution.solve("wtnhxymk"))

IO.inspect(DayFiveSolution.solve_second_part("abc"))
IO.inspect(DayFiveSolution.solve_second_part("wtnhxymk"))
