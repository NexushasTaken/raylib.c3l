module rl @if($feature(SUPPORT_FILE_SYSTEM_FUNCTIONS));

// File system functions
//------------------------------------------------------------------------------------

<*
 Check if file exists
*>
extern fn bool fileExists(ZString file_name) @extern("FileExists");

<*
 Check if a directory path exists
*>
extern fn bool directoryExists(ZString dir_path) @extern("DirectoryExists");

<*
 Check file extension (including point: .png, .wav)
*>
extern fn bool isFileExtension(ZString file_name, ZString ext) @extern("IsFileExtension");

<*
 Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
*>
extern fn int getFileLength(ZString file_name) @extern("GetFileLength");

<*
 Get pointer to extension for a filename string (includes dot: '.png')
*>
extern fn ZString getFileExtension(ZString file_name) @extern("GetFileExtension");

<*
 Get pointer to filename for a path string
*>
extern fn ZString getFileName(ZString file_path) @extern("GetFileName");

<*
 Get filename string without extension (uses static string)
*>
extern fn ZString getFileNameWithoutExt(ZString file_path) @extern("GetFileNameWithoutExt");

<*
 Get full path for a given fileName with path (uses static string)
*>
extern fn ZString getDirectoryPath(ZString file_path) @extern("GetDirectoryPath");

<*
 Get previous directory path for a given path (uses static string)
*>
extern fn ZString getPrevDirectoryPath(ZString dir_path) @extern("GetPrevDirectoryPath");

<*
 Get current working directory (uses static string)
*>
extern fn ZString getWorkingDirectory() @extern("GetWorkingDirectory");

<*
 Get the directory of the running application (uses static string)
*>
extern fn ZString getApplicationDirectory() @extern("GetApplicationDirectory");

<*
 Change working directory, return true on success
*>
extern fn bool changeDirectory(ZString dir) @extern("ChangeDirectory");

<*
 Check if a given path is a file or a directory
*>
extern fn bool isPathFile(ZString path) @extern("IsPathFile");

<*
 Load directory filepaths
*>
extern fn FilePathList loadDirectoryFiles(ZString  dir_path) @extern("LoadDirectoryFiles");

<*
 Load directory filepaths with extension filtering and recursive directory scan
*>
extern fn FilePathList loadDirectoryFilesEx(ZString base_path, ZString filter, bool scan_subdirs) @extern("LoadDirectoryFilesEx");

<*
 Unload filepaths
*>
extern fn void unloadDirectoryFiles(FilePathList files) @extern("UnloadDirectoryFiles");

<*
 Check if a file has been dropped into window
*>
extern fn bool isFileDropped() @extern("IsFileDropped");

<*
 Load dropped filepaths
*>
extern fn FilePathList loadDroppedFiles() @extern("LoadDroppedFiles");

<*
 Unload dropped filepaths
*>
extern fn void unloadDroppedFiles(FilePathList files) @extern("UnloadDroppedFiles");

<*
 Get file modification time (last write time)
*>
extern fn long getFileModTime(ZString file_name) @extern("GetFileModTime");
