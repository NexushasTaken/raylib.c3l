module rl;

// Callbacks to hook some internal functions
// WARNING: These callbacks are intended for advanced users
alias LoadFileDataCallback = fn ZString(ZString file_name, int* data_size);          // FileIO: Load binary data
alias SaveFileDataCallback = fn bool(ZString file_name, void* data, uint data_size); // FileIO: Save binary data
alias LoadFileTextCallback = fn ZString(ZString file_name);                          // FileIO: Load text data
alias SaveFileTextCallback = fn bool(ZString file_name, ZString text);               // FileIO: Save text data
