import gleam/int
import gleam/list
import gleam/result
import gleam/string
import util

pub fn day_01() -> #(Int, Int) {
  let part_a_input = util.read_file_lines("./input/1a.txt")
  #(part_01(part_a_input), 0)
}

fn part_01(lines: List(String)) -> Int {
  list.map_fold(over: lines, from: 50, with: fn(accum, dial_val) {
    let components = string.pop_grapheme(dial_val) |> result.unwrap(#("X", "0"))
    let val = accum % 100
    // NOTE: I think there's a slight bug here where if the last value happens to be 0
    // I won't find it correctly, but idc
    case components.0 {
      "L" -> {
        #(accum - { int.parse(components.1) |> result.unwrap(0) }, val)
      }
      "R" -> {
        #(accum + { int.parse(components.1) |> result.unwrap(0) }, val)
      }
      _ -> {
        // theoretically unreachable
        let err = "Bad input" <> components.0 <> " " <> components.1
        panic as err
      }
    }
  }).1
  |> echo
  |> list.count(fn(dial_val) { dial_val == 0 })
}
