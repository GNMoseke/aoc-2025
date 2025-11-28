import day_01
import gleam/int
import gleam/io

pub fn main() -> Nil {
  io.println(day_01.day_01() |> int.to_string())
}
