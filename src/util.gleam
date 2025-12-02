import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_file_lines(path: String) -> List(String) {
  simplifile.read(from: path)
  |> result.unwrap("")
  // error handling is for losers in AOC
  |> string.split(on: "\n")
  |> list.filter(fn(line) { !string.is_empty(line) })
}

pub fn read_file_comma_delim(path: String) -> List(String) {
  simplifile.read(from: path)
  |> result.unwrap("")
  // error handling is for losers in AOC
  |> string.split(on: ",")
  |> list.filter(fn(line) { !string.is_empty(line) })
  |> list.map(string.trim)
}

pub fn split_n(str: String, n: Int) -> List(String) {
  split_n_rec(str, n, [])
}

fn split_n_rec(str: String, n: Int, accum: List(String)) -> List(String) {
  case n >= string.length(str) {
    True -> {
      list.append(accum, [str])
    }
    False -> {
      let prefix = string.slice(from: str, at_index: 0, length: n)
      string.slice(from: str, at_index: n, length: { string.length(str) - n })
      |> split_n_rec(n, list.append(accum, [prefix]))
    }
  }
}
