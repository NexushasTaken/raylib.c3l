module rl @if($feature(SUPPORT_STANDARD_FILEIO));
import std::io;

// Set custom callbacks
// WARNING: Callbacks setup is intended for advance users
//------------------------------------------------------------------------------------

<*
 Set custom file binary data loader
*>
extern fn void setLoadFileDataCallback(LoadFileDataCallback callback) @extern("SetLoadFileDataCallback");

<*
 Set custom file binary data saver
*>
extern fn void setSaveFileDataCallback(SaveFileDataCallback callback) @extern("SetSaveFileDataCallback");

<*
 Set custom file text data loader
*>
extern fn void setLoadFileTextCallback(LoadFileTextCallback callback) @extern("SetLoadFileTextCallback");

<*
 Set custom file text data saver
*>
extern fn void setSaveFileTextCallback(SaveFileTextCallback callback) @extern("SetSaveFileTextCallback");

// Files management functions
//------------------------------------------------------------------------------------

<*
 Load file data as byte array (read)
*>
fn char[] loadFileData(ZString file_name) @inline {
    int len = 0;
    char* ptr = __load_file_data(file_name, &len);
    return ptr[:(usz)len];
}

<*
 Unload file data allocated by LoadFileData()
*>
fn void unloadFileData(char[] data) @inline {
    __unload_file_data(data.ptr);
}

<*
 Save data to file from byte array (write), returns true on success
*>
extern fn bool saveFileData(ZString file_name, void* data, int data_size) @extern("SaveFileData");

// TODO: review
<*
 Export data to code (.h), returns true on success
*>
macro bool exportDataAsCode(ZString file_name, char[] data) {
    return __export_data_as_code(data.ptr, data.len, file_name);
}

<*
 Load text data from file (read), returns a '\0' terminated string
*>
fn ZString! loadFileText(ZString file_name) @inline {
    char* zstr = __load_file_text(file_name);
    return zstr == null ? io::IoError.UNKNOWN_ERROR? : (ZString)zstr;
}

<*
 Unload file text data allocated by LoadFileText()
*>
extern fn void unloadFileText(ZString text) @extern("UnloadFileText");

<*
 Save text data to file (write), string must be '\0' terminated, returns true on success
*>
extern fn bool saveFileText(ZString file_name, ZString text) @extern("SaveFileText");
//------------------------------------------------------------------
