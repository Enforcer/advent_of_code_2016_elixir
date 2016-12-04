defmodule DayTwoSolution do

  @first_digit "5"

  def solve(input, moves) do
    Enum.reduce(String.split(input, "\n"), {"", @first_digit},
      fn(line, {code, starting_digit}) ->
      {code_part, last_digit} = get_last_digit(line, starting_digit, moves)
      {code <> code_part <> last_digit, last_digit}
    end)
  end

  defp get_last_digit(line, starting_digit, moves) do
    String.graphemes(line)
    |> Enum.reduce({"", starting_digit}, fn(letter, {code, digit}) ->

      case moves[digit][letter] do
        {:stop, old_digit} ->
          {code, old_digit}
        {:next, new_digit} ->
          {code, new_digit}
        end
    end)
  end
end

test_input = "ULL
RRDDD
LURDL
UUUUD"

task_input = "RRLUDDLDUDUDUDRDDDRDDRLUUUDRUDURURURLRDDULLLDRRRRULDDRDDURDLURLURRUULRURDDDDLDDRRLDUDUUDURURDLDRRURDLLLDLLRUDRLDDRUULLLLLRRLDUDLUUDRUULLRLLLRLUURDLDLLDDRULDLUURRURLUUURLLDDULRDULULRULDDLRDDUUDLRRURLLURURLDDLURRLUURRRRLDRDLDUDRUDDRULLDUDDLRRLUUUUUDDLLDRLURDDRLLUDULDRDDLLUURUUUURDRLRLLULUULULLRRDLULRUDURDLRLRDDDRULLUULRURULLLUDUURUUUURUULDURDRRRULRLULDLRRULULUUDDDRDURLLURLLDUUUUDULRDLRDUUDDLDUDRLLRLRRRLULUDDDURLRRURUDDDRDRDRLLRDRDLDDRRDRDLLRLLLRRULRDDURRDUDRURDLDULLRRLURLRLLDURRRLLDRRURRRUULDRLDUULRDLDLURUDLLDLLUUDDDUUUDRL
DLRRDRRDDRRDURLUDDDDDULDDLLDRLURDDDDDDRDDDRDDDLLRRULLLRUDULLDURULRRDLURURUDRUURDRLUURRUDRUULUURULULDDLLDDRLDUDDRDRDDUULDULDDLUDUDDUDLULLUDLLLLLRRRUURLUUUULRURULUDDULLLRLRDRUUULULRUUUULRDLLDLDRDRDRDRRUUURULDUUDLDRDRURRUDDRLDULDDRULRRRLRDDUUDRUDLDULDURRDUDDLULULLDULLLRRRDULLLRRURDUURULDRDURRURRRRDLDRRUDDLLLDRDRDRURLUURURRUUURRUDLDDULDRDRRURDLUULDDUUUURLRUULRUURLUUUDLUDRLURUDLDLDLURUURLDURDDDDRURULLULLDRDLLRRLDLRRRDURDULLLDLRLDR
URURLLDRDLULULRDRRDDUUUDDRDUURULLULDRLUDLRUDDDLDRRLURLURUUDRLDUULDRDURRLLUDLDURRRRLURLDDRULRLDULDDRRLURDDRLUDDULUDULRLDULDLDUDRLLDDRRRDULLDLRRLDRLURLUULDDDDURULLDLLLDRRLRRLLRDDRDLDRURRUURLLDDDLRRRRRDLRRDRLDDDLULULRLUURULURUUDRULRLLRDLDULDRLLLDLRRRUDURLUURRUDURLDDDRDRURURRLRRLDDRURULDRUURRLULDLUDUULDLUULUDURRDDRLLLRLRRLUUURRDRUULLLRUUURLLDDRDRULDULURRDRURLRRLRDURRURRDLDUDRURUULULDDUDUULDRDURRRDLURRLRLDUDRDULLURLRRUDLUDRRRULRURDUDDDURLRULRRUDUUDDLLLURLLRLLDRDUURDDLUDLURDRRDLLRLURRUURRLDUUUUDUD
DRRDRRRLDDLDUDRDLRUUDRDUDRRDUDRDURRDDRLLURUUDRLRDDULLUULRUUDDRLDLRULDLRLDUDULUULLLRDLURDRDURURDUDUDDDRRLRRLLRULLLLRDRDLRRDDDLULDLLUUULRDURRULDDUDDDURRDRDRDRULRRRDRUDLLDDDRULRRLUDRDLDLDDDLRLRLRLDULRLLRLRDUUULLRRDLLRDULURRLDUDDULDDRLUDLULLRLDUDLULRDURLRULLRRDRDDLUULUUUULDRLLDRDLUDURRLLDURLLDDLLUULLDURULULDLUUDLRURRRULUDRLDRDURLDUDDULRDRRDDRLRRDDRUDRURULDRRLUURUDULDDDLRRRRDRRRLLURUURLRLULUULLRLRDLRRLLUULLDURDLULURDLRUUDUUURURUURDDRLULUUULRDRDRUUDDDRDRL
RLRUDDUUDDDDRRLRUUDLLDRUUUDRRDLDRLRLLDRLUDDURDLDUDRRUURULLRRLUULLUDRDRUDDULRLLUDLULRLRRUUDLDLRDDDRDDDUDLULDLRRLUDUDDRRRRDRDRUUDDURLRDLLDLDLRRDURULDRLRRURULRDDLLLRULLRUUUDLDUURDUUDDRRRDDRLDDRULRRRDRRLUDDDRUURRDRRDURDRUDRRDLUDDURRLUDUDLLRUURLRLLLDDURUDLDRLRLLDLLULLDRULUURLDDULDDRDDDURULLDRDDLURRDDRRRLDLRLRRLLDLLLRDUDDULRLUDDUULUDLDDDULULDLRDDLDLLLDUUDLRRLRDRRUUUURLDLRRLDULURLDRDURDDRURLDLDULURRRLRUDLDURDLLUDULDDU"

moves_simple  = %{
  "1" => %{"U" => {:stop, "1"}, "D" => {:next, "4"}, "L" => {:stop, "1"}, "R" => {:next, "2"}},
  "2" => %{"U" => {:stop, "2"}, "D" => {:next, "5"}, "L" => {:next, "1"}, "R" => {:next, "3"}},
  "3" => %{"U" => {:stop, "3"}, "D" => {:next, "6"}, "L" => {:next, "2"}, "R" => {:stop, "3"}},
  "4" => %{"U" => {:next, "1"}, "D" => {:next, "7"}, "L" => {:stop, "4"}, "R" => {:next, "5"}},
  "5" => %{"U" => {:next, "2"}, "D" => {:next, "8"}, "L" => {:next, "4"}, "R" => {:next, "6"}},
  "6" => %{"U" => {:next, "3"}, "D" => {:next, "9"}, "L" => {:next, "5"}, "R" => {:stop, "6"}},
  "7" => %{"U" => {:next, "4"}, "D" => {:stop, "7"}, "L" => {:stop, "7"}, "R" => {:next, "8"}},
  "8" => %{"U" => {:next, "5"}, "D" => {:stop, "8"}, "L" => {:next, "7"}, "R" => {:next, "9"}},
  "9" => %{"U" => {:next, "6"}, "D" => {:stop, "9"}, "L" => {:next, "8"}, "R" => {:stop, "9"}}
}

moves_harder = %{
  "1" => %{"U" => {:stop, "1"}, "D" => {:next, "3"}, "L" => {:stop, "1"}, "R" => {:stop, "1"}},
  "2" => %{"U" => {:stop, "2"}, "D" => {:next, "6"}, "L" => {:stop, "2"}, "R" => {:next, "3"}},
  "3" => %{"U" => {:next, "1"}, "D" => {:next, "7"}, "L" => {:next, "2"}, "R" => {:next, "4"}},
  "4" => %{"U" => {:stop, "4"}, "D" => {:next, "8"}, "L" => {:next, "3"}, "R" => {:stop, "4"}},
  "5" => %{"U" => {:stop, "5"}, "D" => {:stop, "5"}, "L" => {:stop, "5"}, "R" => {:next, "6"}},
  "6" => %{"U" => {:next, "2"}, "D" => {:next, "A"}, "L" => {:next, "5"}, "R" => {:next, "7"}},
  "7" => %{"U" => {:next, "3"}, "D" => {:next, "B"}, "L" => {:next, "6"}, "R" => {:next, "8"}},
  "8" => %{"U" => {:next, "4"}, "D" => {:next, "C"}, "L" => {:next, "7"}, "R" => {:next, "9"}},
  "9" => %{"U" => {:stop, "9"}, "D" => {:stop, "9"}, "L" => {:next, "8"}, "R" => {:stop, "9"}},
  "A" => %{"U" => {:next, "6"}, "D" => {:stop, "A"}, "L" => {:stop, "A"}, "R" => {:next, "B"}},
  "B" => %{"U" => {:next, "7"}, "D" => {:next, "D"}, "L" => {:next, "A"}, "R" => {:next, "C"}},
  "C" => %{"U" => {:next, "8"}, "D" => {:stop, "C"}, "L" => {:next, "B"}, "R" => {:stop, "C"}},
  "D" => %{"U" => {:next, "B"}, "D" => {:stop, "D"}, "L" => {:stop, "D"}, "R" => {:stop, "D"}},
}

solution = DayTwoSolution.solve(task_input, moves_simple)
IO.inspect(solution)

solution_2 = DayTwoSolution.solve(task_input, moves_harder)
IO.inspect(solution_2)
