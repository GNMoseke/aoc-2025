import day_01
import gleam/int
import gleam/io

pub fn main() -> Nil {
  let day_01_soln = day_01.day_01()
  io.println(
    "Day 1: \n    "
    <> "Part 1: "
    <> day_01_soln.0 |> int.to_string()
    <> "\n    Part 2: "
    <> day_01_soln.1 |> int.to_string(),
  )
}
