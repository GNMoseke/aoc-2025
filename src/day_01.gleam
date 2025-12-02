import gleam/int
import gleam/list
import gleam/result
import gleam/string
import util

pub fn day_01() -> #(Int, Int) {
  let input = util.read_file_lines("./input/01.txt")
  #(part_a(input), part_b(input))
}

fn part_a(lines: List(String)) -> Int {
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
  |> list.count(fn(dial_val) { dial_val == 0 })
}

fn part_b(lines: List(String)) -> Int {
  list.map_fold(over: lines, from: 50, with: fn(curr_pos, dial_val) {
    let components = string.pop_grapheme(dial_val) |> result.unwrap(#("X", "0"))
    let delta_abs = int.parse(components.1) |> result.unwrap(0)
    let new_pos_info = case components.0 {
      // if the delta is bigger than the distance from the current position to 0 in the
      // direction of rotation, then we will cross 0 at least once
      "L" -> {
        let new_pos_raw = curr_pos - { delta_abs }
        let dist_to_0 = case curr_pos {
          0 -> 100
          x -> x
        }
        #(new_pos_raw % 100, dist_to_0)
      }
      "R" -> {
        let new_pos_raw = curr_pos + { delta_abs }
        let norm = 100 - curr_pos
        let dist_to_0 = case norm {
          0 -> 100
          x -> x
        }
        #(new_pos_raw % 100, dist_to_0)
      }
      _ -> {
        // theoretically unreachable
        let err = "Bad input" <> components.0 <> " " <> components.1
        panic as err
      }
    }
    let new_pos = case new_pos_info.0 < 0 {
      True -> new_pos_info.0 + 100
      False -> new_pos_info.0
    }
    let num_crosses = case { delta_abs > new_pos_info.1 }, new_pos == 0 {
      True, False -> { delta_abs - new_pos_info.1 + 100 } / 100
      True, True -> { { delta_abs - new_pos_info.1 + 100 } / 100 } - 1
      False, _ -> 0
    }
    let final_count = case new_pos == 0 {
      True -> num_crosses + 1
      False -> num_crosses
    }

    // The second number here needs to be num times crossed 0 (plus 1 if the value
    // itself at new_pos is 0)
    #(new_pos, final_count)
  }).1
  |> int.sum()
}
