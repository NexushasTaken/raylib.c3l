module rl;

//------------------------------------------------------------------------------------
// Audio Loading and Playing Functions (Module: audio)
//------------------------------------------------------------------------------------

/*

Index of this module:
// Audio device management functions
// Wave/Sound loading/unloading functions
// Wave/Sound management functions
// Music management functions
// AudioStream management functions

*/

def AudioCallback = fn void(void* buffer_data, uint frames);

// Audio device management functions
//------------------------------------------------------------------------------------

<*
 Initialize audio device and context
*>
extern fn void initAudioDevice() @extern("InitAudioDevice");

<*
 Close the audio device and context
*>
extern fn void closeAudioDevice() @extern("CloseAudioDevice");

<*
 Check if audio device has been initialized successfully
*>
extern fn bool isAudioDeviceReady() @extern("IsAudioDeviceReady");

<*
 // TODO: is max volume 1.0f is allowed?
 Set master volume (listener)
 @require volume >= 0.0f
*>
extern fn void setMasterVolume(float volume) @extern("SetMasterVolume");

<*
 Get master volume (listener)
 @ensure return >= 0.0f
*>
extern fn float getMasterVolume() @extern("GetMasterVolume");

// Wave/Sound loading/unloading functions
//------------------------------------------------------------------------------------

<*
 Load wave data from file
*>
extern fn Wave loadWave(ZString file_name) @extern("LoadWave");

<*
 Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
*>
fn Wave loadWaveFromMemory(ZString file_type, String file_data) @inline {
	return __load_wave_from_memory(file_type, file_data.ptr, (int)file_data.len);
}

<*
 Checks if wave data is valid (data loaded and parameters)
*>
extern fn bool isWaveValid(Wave wave) @extern("IsWaveValid");

<*
 Load sound from file
*>
extern fn Sound loadSound(ZString file_name) @extern("LoadSound");

<*
 Load sound from wave data
*>
extern fn Sound loadSoundFromWave(Wave wave) @extern("LoadSoundFromWave");

<*
 Create a new sound that shares the same sample data as the source sound, does not own the sound data
*>
extern fn Sound loadSoundAlias(Sound source) @extern("LoadSoundAlias");

<*
 Checks if a sound is valid (data loaded and buffers initialized)
*>
extern fn bool isSoundValid(Sound sound) @extern("IsSoundValid");

<*
 Update sound buffer with new data
*>
extern fn void updateSound(Sound sound, void* data, int sample_count) @extern("UpdateSound");

<*
 Unload wave data
*>
extern fn void unloadWave(Wave wave) @extern("UnloadWave");

<*
 Unload sound
*>
extern fn void unloadSound(Sound sound) @extern("UnloadSound");

<*
 Unload a sound alias (does not deallocate sample data)
*>
extern fn void unloadSoundAlias(Sound alias) @extern("UnloadSoundAlias");

<*
 Export wave data to file, returns true on success
*>
extern fn bool exportWave(Wave wave, ZString file_name) @extern("ExportWave");

<*
 Export wave sample data to code (.h), returns true on success
*>
extern fn bool exportWaveAsCode(Wave wave, ZString file_name) @extern("ExportWaveAsCode");

// Wave/Sound management functions
//------------------------------------------------------------------------------------

<*
 Play a sound
*>
extern fn void playSound(Sound sound) @extern("PlaySound");

<*
 Stop playing a sound
*>
extern fn void stopSound(Sound sound) @extern("StopSound");

<*
 Pause a sound
*>
extern fn void pauseSound(Sound sound) @extern("PauseSound");

<*
 Resume a paused sound
*>
extern fn void resumeSound(Sound sound) @extern("ResumeSound");

<*
 Check if a sound is currently playing
*>
extern fn bool isSoundPlaying(Sound sound) @extern("IsSoundPlaying");

<*
 Set volume for a sound (1.0 is max level)
 @require volume >= 0.0f && volume <= 1.0f
*>
extern fn void setSoundVolume(Sound sound, float volume) @extern("SetSoundVolume");

<*
 Set pitch for a sound (1.0 is base level)
 @require pitch >= 0.0f
*>
extern fn void setSoundPitch(Sound sound, float pitch) @extern("SetSoundPitch");

<*
 Set pan for a sound (0.5 is center)
 @require pan >= 0.0f && pan <= 1.0f
*>
extern fn void setSoundPan(Sound sound, float pan) @extern("SetSoundPan");

<*
 Copy a wave to a new wave
*>
extern fn Wave waveCopy(Wave wave) @extern("WaveCopy");

<*
 Crop a wave to defined frames range
*>
extern fn void waveCrop(Wave *wave, int init_frame, int final_frame) @extern("WaveCrop");

<*
 Convert wave data to desired format
*>
extern fn void waveFormat(Wave* wave, int sample_rate, int sample_size, int channels) @extern("WaveFormat");

<*
 Load samples data from wave as a 32bit float data array
*>
extern fn float* loadWaveSamples(Wave wave) @extern("LoadWaveSamples");

<*
 Unload samples data loaded with LoadWaveSamples()
*>
extern fn void unloadWaveSamples(float* samples) @extern("UnloadWaveSamples");

// Music management functions
//------------------------------------------------------------------------------------

<*
 Load music stream from file
*>
extern fn Music loadMusicStream(ZString file_name) @extern("LoadMusicStream");

<*
 Load music stream from data
*>
extern fn Music loadMusicStreamFromMemory(ZString file_type, ZString data, int data_size) @extern("LoadMusicStreamFromMemory");

<*
 Checks if a music stream is valid (context and buffers initialized)
*>
extern fn bool isMusicValid(Music music) @extern("IsMusicValid");

<*
 Unload music stream
*>
extern fn void unloadMusicStream(Music music) @extern("UnloadMusicStream");

<*
 Start music playing
*>
extern fn void playMusicStream(Music music) @extern("PlayMusicStream");

<*
 Check if music is playing
*>
extern fn bool isMusicStreamPlaying(Music music) @extern("IsMusicStreamPlaying");

<*
 Updates buffers for music streaming
*>
extern fn void updateMusicStream(Music music) @extern("UpdateMusicStream");

<*
 Stop music playing
*>
extern fn void stopMusicStream(Music music) @extern("StopMusicStream");

<*
 Pause music playing
*>
extern fn void pauseMusicStream(Music music) @extern("PauseMusicStream");

<*
 Resume playing paused music
*>
extern fn void resumeMusicStream(Music music) @extern("ResumeMusicStream");

<*
 Seek music to a position (in seconds)
*>
extern fn void seekMusicStream(Music music, float position) @extern("SeekMusicStream");

<*
 Set volume for music (1.0 is max level)
 @require volume >= 0.0f && volume <= 1.0f
*>
extern fn void setMusicVolume(Music music, float volume) @extern("SetMusicVolume");

<*
 Set pitch for a music (1.0 is base level)
 @require pitch >= 0.0f
*>
extern fn void setMusicPitch(Music music, float pitch) @extern("SetMusicPitch");

<*
 Set pan for a music (0.pan >= 0.0f5 is center)
 @require pan >= 0.0f && pan <= 1.0f
*>
extern fn void setMusicPan(Music music, float pan) @extern("SetMusicPan");

<*
 Get music time length (in seconds)
*>
extern fn float getMusicTimeLength(Music music) @extern("GetMusicTimeLength");

<*
 Get current music time played (in seconds)
*>
extern fn float getMusicTimePlayed(Music music) @extern("GetMusicTimePlayed");

// AudioStream management functions
//------------------------------------------------------------------------------------

<*
 Load audio stream (to stream raw audio pcm data)
*>
extern fn AudioStream loadAudioStream(uint sample_rate, uint sample_size, uint channels) @extern("LoadAudioStream");

<*
 Checks if an audio stream is valid (buffers initialized)
*>
extern fn bool isAudioStreamValid(AudioStream stream) @extern("IsAudioStreamValid");

<*
 Unload audio stream and free memory
*>
extern fn void unloadAudioStream(AudioStream stream) @extern("UnloadAudioStream");

<*
 Update audio stream buffers with data
*>
extern fn void updateAudioStream(AudioStream stream, void* data, int frame_count) @extern("UpdateAudioStream");

<*
 Check if any audio stream buffers requires refill
*>
extern fn bool isAudioStreamProcessed(AudioStream stream) @extern("IsAudioStreamProcessed");

<*
 Play audio stream
*>
extern fn void playAudioStream(AudioStream stream) @extern("PlayAudioStream");

<*
 Pause audio stream
*>
extern fn void pauseAudioStream(AudioStream stream) @extern("PauseAudioStream");

<*
 Resume audio stream
*>
extern fn void resumeAudioStream(AudioStream stream) @extern("ResumeAudioStream");

<*
 Check if audio stream is playing
*>
extern fn bool isAudioStreamPlaying(AudioStream stream) @extern("IsAudioStreamPlaying");

<*
 Stop audio stream
*>
extern fn void stopAudioStream(AudioStream stream) @extern("StopAudioStream");

<*
 Set volume for audio stream (1.0 is max level)
 @require volume >= 0.0f && volume <= 1.0f
*>
extern fn void setAudioStreamVolume(AudioStream stream, float volume) @extern("SetAudioStreamVolume");

<*
 Set pitch for audio stream (1.0 is base level)
 @require pitch >= 0.0f
*>
extern fn void setAudioStreamPitch(AudioStream stream, float pitch) @extern("SetAudioStreamPitch");

<*
 Set pan for audio stream (0.5 is centered)
 @require pan >= 0.0f && pan <= 1.0f
*>
extern fn void setAudioStreamPan(AudioStream stream, float pan) @extern("SetAudioStreamPan");

<*
 Default size for new audio streams
*>
extern fn void setAudioStreamBufferSizeDefault(int size) @extern("SetAudioStreamBufferSizeDefault");

<*
 Audio thread callback to request new data
*>
extern fn void setAudioStreamCallback(AudioStream stream, AudioCallback callback) @extern("SetAudioStreamCallback");

<*
 Attach audio stream processor to stream, receives the samples as 'float'
*>
extern fn void attachAudioStreamProcessor(AudioStream stream, AudioCallback processor) @extern("AttachAudioStreamProcessor");

<*
 Detach audio stream processor from stream
*>
extern fn void detachAudioStreamProcessor(AudioStream stream, AudioCallback processor) @extern("DetachAudioStreamProcessor");

<*
 Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'
*>
extern fn void attachAudioMixedProcessor(AudioCallback processor) @extern("AttachAudioMixedProcessor");

<*
 Detach audio stream processor from the entire audio pipeline
*>
extern fn void detachAudioMixedProcessor(AudioCallback processor) @extern("DetachAudioMixedProcessor");
