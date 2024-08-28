import std::io;
import std::core::runtime;
import rl @public;

fn void! test() {
}

fn int main(String[] args) {
  TestUnit[] unit = {
    { "Test", &test },
  };

  runtime::run_tests(unit);
  return 0;
}
