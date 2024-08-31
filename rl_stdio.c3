// vi: ts=4 sw=4
module rl @if(config::SUPPORT_STANDARD_FILEIO);
import std::io;

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
//------------------------------------------------------------------------------------

/**
 * Set custom file binary data loader
 */
extern fn void set_load_file_data_callback(LoadFileDataCallback callback) @extern("SetLoadFileDataCallback");

/**
 * Set custom file binary data saver
 */
extern fn void set_save_file_data_callback(SaveFileDataCallback callback) @extern("SetSaveFileDataCallback");

/**
 * Set custom file text data loader
 */
extern fn void set_load_file_text_callback(LoadFileTextCallback callback) @extern("SetLoadFileTextCallback");

/**
 * Set custom file text data saver
 */
extern fn void set_save_file_text_callback(SaveFileTextCallback callback) @extern("SetSaveFileTextCallback");

// Files management functions
//------------------------------------------------------------------------------------

/**
 * Load file data as byte array (read)
 */
fn char[] load_file_data(ZString file_name) @inline {
    int len = 0;
    char* ptr = __load_file_data(file_name, &len);
    return ptr[:(usz)len];
}

/**
 * Unload file data allocated by LoadFileData()
 */
fn void unload_file_data(char[] data) @inline {
    __unload_file_data(data.ptr);
}

/**
 * Save data to file from byte array (write), returns true on success
 */
extern fn bool save_file_data(ZString file_name, void* data, int data_size) @extern("SaveFileData");

// TODO: review
/**
 * Export data to code (.h), returns true on success
 */
macro bool export_data_as_code(ZString file_name, char[] data) {
    return __export_data_as_code(data.ptr, data.len, file_name);
}

/**
 * Load text data from file (read), returns a '\0' terminated string
 */
fn ZString! load_file_text(ZString file_name) @inline {
    char* zstr = __load_file_text(file_name);
    return zstr == null ? io::IoError.UNKNOWN_ERROR? : (ZString)zstr;
}

/**
 * Unload file text data allocated by LoadFileText()
 */
extern fn void unload_file_text(ZString text) @extern("UnloadFileText");

/**
 * Save text data to file (write), string must be '\0' terminated, returns true on success
 */
extern fn bool save_file_text(ZString file_name, ZString text) @extern("SaveFileText");
//------------------------------------------------------------------

