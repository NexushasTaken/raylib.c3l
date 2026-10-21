import std::io;
import rl @public;

fn void test_encode_data_base64() @test {
  io::printn();

  char[] str = "Hello, World";

  int len_encod = 0;
  char[] ffi_encod = rl::__encode_data_base64(str.ptr, str.len, &len_encod)[:len_encod];
  defer free(ffi_encod);

  char[] wra_encod = rl::encodeDataBase64(str);
  defer free(wra_encod);

  io::printn(ffi_encod);
  io::printn(wra_encod);
  assert(ffi_encod == wra_encod);

  int len_decod = 0;
  char[] ffi_decod = rl::__decode_data_base64(ffi_encod.ptr, &len_decod)[:len_decod];
  defer free(ffi_decod);

  char[] wra_decod = rl::decodeDataBase64(wra_encod);
  defer free(wra_decod);

  io::printn(ffi_decod);
  io::printn(wra_decod);
  assert(ffi_decod == wra_decod);
}
