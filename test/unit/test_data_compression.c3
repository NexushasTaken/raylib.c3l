import std::io;
import std::core::runtime;
import rl @public;

fn void? test_compression() {
  io::printn();

  char[] str = "Hello, World";

  int len_comp = 0;
  char[] ffi_comp = rl::__compress_data(str.ptr, str.len, &len_comp)[:len_comp];
  defer free(ffi_comp);

  char[] wra_comp = rl::compress_data(str);
  defer free(wra_comp);

  print_as_hex(ffi_comp);
  print_as_hex(wra_comp);

  assert(ffi_comp == wra_comp);

  int len_decomp = 0;
  char[] ffi_decomp = rl::__decompress_data(ffi_comp.ptr, ffi_comp.len, &len_decomp)[:len_decomp];
  char[] wra_decomp = rl::decompress_data(wra_comp);
  assert(ffi_decomp == str);
  assert(wra_decomp == str);
}

fn void print_as_hex(char[] data) {
  io::printf("\"");
  foreach (c : data) {
    io::printf("%x", c);
  }
  io::printf("\"\n");
}

fn int main(String[] args) {
  TestUnit[] unit = {
    { "Compress data", &test_compression },
  };

  runtime::run_tests(unit);
  return 0;
}
