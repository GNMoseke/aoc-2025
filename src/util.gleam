import gleam/result
import gleam/string
import simplifile

pub fn read_file_lines(path: String) -> List(String) {
  simplifile.read(from: path)
  |> result.unwrap("") // error handling is for losers in AOC
  |> string.split(on: "\n")
}
