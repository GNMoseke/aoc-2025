import gleam/int
import gleam/list
import gleam/result
import gleam/string
import util

pub fn day_03() -> #(Int, Int) {
  let input = util.read_file_lines("./input/03.txt")
  #(part_a(input), part_b(input))
}

fn part_a(lines: List(String)) -> Int {
  // Pretty sure this is just a left pointer & right pointer problem, move through and
  // save current best
  // now how do I do that in a functional language lol
  // I think it's a two sequence iteration:
  // 1. find the first instance of the max value in the list, excluding the last value of
  // the list
  // 2. do it again, but only check the values after that max index
  parse(lines)
  |> list.map(fn(bank) {
    let first_max = find_max(bank, 1)
    let second_max = find_max(first_max.remainder, 0)
    // there's some way to do this with like some multiplication or something but I don't
    // give a shit
    let f_m_str = int.to_string(first_max.max_val)
    let s_m_str = int.to_string(second_max.max_val)
    let val_str = f_m_str <> s_m_str
    let assert Ok(largest) = int.parse(val_str)
    largest
  })
  |> int.sum()
}

fn part_b(lines: List(String)) -> Int {
  // this is the same thing but instead of excluding the last 1 we exclude 12, 11, etc
  parse(lines)
  |> list.map(fn(bank) {
  let m1 = find_max(bank, 11)
  let m2 = find_max(m1.remainder, 10)
  let m3 = find_max(m2.remainder, 9)
  let m4 = find_max(m3.remainder, 8)
  let m5 = find_max(m4.remainder, 7)
  let m6 = find_max(m5.remainder, 6)
  let m7 = find_max(m6.remainder, 5)
  let m8 = find_max(m7.remainder, 4)
  let m9 = find_max(m8.remainder, 3)
  let m10 = find_max(m9.remainder, 2)
  let m11 = find_max(m10.remainder, 1)
  let m12 = find_max(m11.remainder, 0)

    let s1 = int.to_string(m1.max_val)
    let s2 = int.to_string(m2.max_val)
    let s3 = int.to_string(m3.max_val)
    let s4 = int.to_string(m4.max_val)
    let s5 = int.to_string(m5.max_val)
    let s6 = int.to_string(m6.max_val)
    let s7 = int.to_string(m7.max_val)
    let s8 = int.to_string(m8.max_val)
    let s9 = int.to_string(m9.max_val)
    let s10 = int.to_string(m10.max_val)
    let s11 = int.to_string(m11.max_val)
    let s12 = int.to_string(m12.max_val)

    let val_str = s1 <> s2 <> s3 <> s4 <> s5 <> s6 <> s7 <> s8 <> s9 <> s10 <> s11 <> s12
    let assert Ok(largest) = int.parse(val_str)
    largest
  })
  |> int.sum
}

fn parse(lines: List(String)) -> List(List(Int)) {
  lines
  |> list.map(fn(bank) {
    let trimmed = string.trim(bank)
    string.to_graphemes(trimmed)
    |> list.map(fn(battery) {
      let assert Ok(digit) = int.parse(battery)
      digit
    })
  })
}

type SubBank {
  SubBank(max_val: Int, remainder: List(Int))
}

fn find_max(bank: List(Int), skip_final_count: Int) -> SubBank {
  // https://tour.gleam.run/flow-control/list-recursion/
  case bank {
    [battery, ..rest] ->
      // go up to the second to last index
      find_max_recursive(rest, battery, 2, rest, list.length(bank) - skip_final_count)
    _ -> panic as "should be unreachable"
  }
}

fn find_max_recursive(
  bank: List(Int),
  curr_max: Int,
  curr_idx: Int,
  remainder: List(Int),
  max_index_incl: Int,
) -> SubBank {
  case bank, curr_idx <= max_index_incl {
    // if we've reached the end, we're done and give back the max
    _, False -> {
      SubBank(curr_max, remainder)
    }
    // otherwise, check if the current battery is better than the current max and take it
    // if so
    [battery, ..rest], True -> {
      case battery > curr_max {
        True ->
          find_max_recursive(rest, battery, curr_idx + 1, rest, max_index_incl)
        False ->
          find_max_recursive(
            rest,
            curr_max,
            curr_idx + 1,
            // NOTE: dumb bug here: if this value isn't bigger
            // than the max, we need to keep the original remainder for the subsequent
            // check, otherwise we throw away the current value as a possibility for the
            // second value
            remainder,
            max_index_incl,
          )
      }
    }
    [], True -> panic as "should be unreachable"
  }
}
