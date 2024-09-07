module rl @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

// File system functions
//------------------------------------------------------------------------------------

/**
 * Check if file exists
 */
extern fn bool file_exists(ZString file_name) @extern("FileExists");

/**
 * Check if a directory path exists
 */
extern fn bool directory_exists(ZString dir_path) @extern("DirectoryExists");

/**
 * Check file extension (including point: .png, .wav)
 */
extern fn bool is_file_extension(ZString file_name, ZString ext) @extern("IsFileExtension");

/**
 * Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
 */
extern fn int get_file_length(ZString file_name) @extern("GetFileLength");

/**
 * Get pointer to extension for a filename string (includes dot: '.png')
 */
extern fn ZString get_file_extension(ZString file_name) @extern("GetFileExtension");

/**
 * Get pointer to filename for a path string
 */
extern fn ZString get_file_name(ZString file_path) @extern("GetFileName");

/**
 * Get filename string without extension (uses static string)
 */
extern fn ZString get_file_name_without_ext(ZString file_path) @extern("GetFileNameWithoutExt");

/**
 * Get full path for a given fileName with path (uses static string)
 */
extern fn ZString get_directory_path(ZString file_path) @extern("GetDirectoryPath");

/**
 * Get previous directory path for a given path (uses static string)
 */
extern fn ZString get_prev_directory_path(ZString dir_path) @extern("GetPrevDirectoryPath");

/**
 * Get current working directory (uses static string)
 */
extern fn ZString get_working_directory() @extern("GetWorkingDirectory");

/**
 * Get the directory of the running application (uses static string)
 */
extern fn ZString get_application_directory() @extern("GetApplicationDirectory");

/**
 * Change working directory, return true on success
 */
extern fn bool change_directory(ZString dir) @extern("ChangeDirectory");

/**
 * Check if a given path is a file or a directory
 */
extern fn bool is_path_file(ZString path) @extern("IsPathFile");

/**
 * Load directory filepaths
 */
extern fn FilePathList load_directory_files(ZString  dir_path) @extern("LoadDirectoryFiles");

/**
 * Load directory filepaths with extension filtering and recursive directory scan
 */
extern fn FilePathList load_directory_files_ex(ZString base_path, ZString filter, bool scan_subdirs) @extern("LoadDirectoryFilesEx");

/**
 * Unload filepaths
 */
extern fn void unload_directory_files(FilePathList files) @extern("UnloadDirectoryFiles");

/**
 * Check if a file has been dropped into window
 */
extern fn bool is_file_dropped() @extern("IsFileDropped");

/**
 * Load dropped filepaths
 */
extern fn FilePathList load_dropped_files() @extern("LoadDroppedFiles");

/**
 * Unload dropped filepaths
 */
extern fn void unload_dropped_files(FilePathList files) @extern("UnloadDroppedFiles");

/**
 * Get file modification time (last write time)
 */
extern fn long get_file_mod_time(ZString file_name) @extern("GetFileModTime");
