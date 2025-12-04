import day_01
import day_02
import day_03
import gleam/int
import gleam/io

pub fn main() -> Nil {
  // TODO: un-shit this
  //let day_01_soln = day_01.day_01()
  let day_soln = day_03.day_03()
  io.println(
    "Day 3: \n    "
    <> "Part 1: "
    <> day_soln.0 |> int.to_string()
    <> "\n    Part 2: "
    <> day_soln.1 |> int.to_string(),
  )
}
