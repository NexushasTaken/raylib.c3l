import std::io;
import std::core::runtime;
import rl @public;

fn void! test_export_data_as_code() {
  io::printn();
  String str = "Hello, World";
  ZString file_name = "build/header.h";

  bool success = rl::export_data_as_code(file_name, str);
  print_as_hex(str);
}

fn void print_as_hex(char[] str) {
  io::printf("[");
  foreach (idx, c : str) {
    if (idx != 0) { io::printf(", "); }
    io::printf("0x%x", c);
  }
  io::printf("]\n");
}

fn int main(String[] args) {
  TestUnit[] unit = {
    { "Export data as code", &test_export_data_as_code },
  };

  runtime::run_tests(unit);
  return 0;
}
