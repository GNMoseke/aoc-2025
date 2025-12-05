// graph problem
import gleam/list
import gleam/set
import gleam/string
import util

pub fn day_04() -> #(Int, Int) {
  let input = util.read_file_lines("./input/04.txt") |> parse
  #(part_a(input), part_b(input))
}

fn part_a(grid: set.Set(#(Int, Int))) -> Int {
  // this is a pretty simple graph traversal problem, but I have to learn to do it in a
  // functional lang
  grid
  |> set.to_list
  |> list.map(fn(pos) {
    let #(x, y) = pos
    let check_range = list.range(-1, 1)
    let above =
      check_range
      |> list.map(fn(offset) { grid |> set.contains(#(x - 1, y + offset)) })
    let inline =
      check_range
      |> list.map(fn(offset) { grid |> set.contains(#(x, y + offset)) })
    let below =
      check_range
      |> list.map(fn(offset) { grid |> set.contains(#(x + 1, y + offset)) })

    list.append(list.append(above, inline), below)
    |> list.filter(fn(has_roll) { has_roll == True })
    |> list.length()
  })
  // subtract 1 because inline will always have 1 in it
  |> list.filter(fn(surround_count) { surround_count - 1 < 4 })
  |> list.length()
}

fn part_b(grid: set.Set(#(Int, Int))) -> Int {
  0
}

fn parse(lines: List(String)) -> set.Set(#(Int, Int)) {
  // parse to set of tuples of occupied positions
  let raw_pos =
    lines
    |> list.index_map(fn(line, i) {
      line
      |> string.to_graphemes()
      |> list.index_map(fn(char, j) {
        case char == "@" {
          True -> #(i, j)
          False -> #(-1, -1)
        }
      })
    })
    |> list.flatten
    |> list.filter(fn(pos) { pos != #(-1, -1) })
  set.from_list(raw_pos)
}
