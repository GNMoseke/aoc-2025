import gleam/int
import gleam/list
import gleam/result
import gleam/string
import util

pub fn day_02() -> #(Int, Int) {
  let input = util.read_file_comma_delim("./input/02.txt")
  #(part_a(input), part_b(input))
}

fn part_a(lines: List(String)) -> Int {
  // get len of each num as a string, ignore it if len is odd
  // if len is even, split it in half and compare the two substrings
  // if equal, that is an invalid ID for our eventual sum
  lines
  |> list.fold(0, fn(sum, curr_range) {
    let range_bounds =
      curr_range
      |> string.split_once("-")
      |> result.lazy_unwrap(fn() { panic as "Failed to parse range" })

    // here have to map over IDs from low to high
    let range_invalid_id_sum =
      list.range(
        int.parse(range_bounds.0)
          |> result.lazy_unwrap(fn() { panic as "not an int" }),
        int.parse(range_bounds.1)
          |> result.lazy_unwrap(fn() { panic as "not an int" }),
      )
      |> list.map(fn(id) {
        let id_str = int.to_string(id)
        case string.length(id_str) % 2 == 0 {
          True -> {
            let upper =
              id_str
              |> string.slice(at_index: 0, length: string.length(id_str) / 2)
            case id_str |> string.ends_with(upper) {
              True -> {
                id
              }
              False -> {
                0
              }
            }
          }
          False -> {
            0
          }
        }
      })
      |> int.sum()

    sum + range_invalid_id_sum
  })
}

fn part_b(lines: List(String)) -> Int {
  0
}
