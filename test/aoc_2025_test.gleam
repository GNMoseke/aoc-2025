import gleeunit
import util

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn split_n_test() {
  assert util.split_n("foobarbaz", 3) == ["foo", "bar", "baz"]
  assert util.split_n("foobarba", 3) == ["foo", "bar", "ba"]
  assert util.split_n("foo", 4) == ["foo"]
}
