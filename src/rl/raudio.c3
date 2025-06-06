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

alias AudioCallback = fn void(void* buffer_data, uint frames);

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
extern fn bool Wave.isReady(Wave wave) @extern("IsWaveReady");
alias isWaveReady = Wave.isReady;

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
extern fn Sound Sound.loadAlias(Sound source) @extern("LoadSoundAlias");
alias loadSoundAlias = Sound.loadAlias;

<*
 Checks if a sound is valid (data loaded and buffers initialized)
*>
extern fn bool Sound.isReady(Sound sound) @extern("IsSoundReady");
alias isSoundReady = Sound.isReady;

<*
 Update sound buffer with new data
*>
extern fn void Sound.update(Sound sound, void* data, int sample_count) @extern("UpdateSound");
alias updateSound = Sound.update;

<*
 Unload wave data
*>
extern fn void Wave.unload(Wave wave) @extern("UnloadWave");
alias unloadWave = Wave.unload;

<*
 Unload sound
*>
extern fn void Sound.unload(Sound sound) @extern("UnloadSound");
alias unloadSound = Sound.unload;

// TODO: Test this
<*
 Unload a sound alias (does not deallocate sample data)
*>
extern fn void Sound.unloadAlias(Sound def) @extern("UnloadSoundAlias");
alias unloadSoundAlias = Sound.unloadAlias;

<*
 Export wave data to file, returns true on success
*>
extern fn bool Wave.export(Wave wave, ZString file_name) @extern("ExportWave");
alias exportWave = Wave.export;

<*
 Export wave sample data to code (.h), returns true on success
*>
extern fn bool Wave.exportAsCode(Wave wave, ZString file_name) @extern("ExportWaveAsCode");
alias exportWaveAsCode = Wave.exportAsCode;

// Wave/Sound management functions
//------------------------------------------------------------------------------------

<*
 Play a sound
*>
extern fn void Sound.play(Sound sound) @extern("PlaySound");
alias playSound = Sound.play;

<*
 Stop playing a sound
*>
extern fn void Sound.stop(Sound sound) @extern("StopSound");
alias stopSound = Sound.stop;

<*
 Pause a sound
*>
extern fn void Sound.pause(Sound sound) @extern("PauseSound");
alias pauseSound = Sound.pause;

<*
 Resume a paused sound
*>
extern fn void Sound.resume(Sound sound) @extern("ResumeSound");
alias resumeSound = Sound.resume;

<*
 Check if a sound is currently playing
*>
extern fn bool Sound.isPlaying(Sound sound) @extern("IsSoundPlaying");
alias isSoundPlaying = Sound.isPlaying;

<*
 Set volume for a sound (1.0 is max level)
 @require volume >= 0.0f && volume <= 1.0f
*>
extern fn void Sound.setVolume(Sound sound, float volume) @extern("SetSoundVolume");
alias setSoundVolume = Sound.setVolume;

<*
 Set pitch for a sound (1.0 is base level)
 @require pitch >= 0.0f
*>
extern fn void Sound.setPitch(Sound sound, float pitch) @extern("SetSoundPitch");
alias setSoundPitch = Sound.setPitch;

<*
 Set pan for a sound (0.5 is center)
 @require pan >= 0.0f && pan <= 1.0f
*>
extern fn void Sound.setPan(Sound sound, float pan) @extern("SetSoundPan");
alias setSoundPan = Sound.setPan;

<*
 Copy a wave to a new wave
*>
extern fn Wave Wave.copy(Wave wave) @extern("WaveCopy");
alias waveCopy = Wave.copy;

<*
 Crop a wave to defined frames range
*>
extern fn void Wave.crop(Wave *wave, int init_frame, int final_frame) @extern("WaveCrop");
alias waveCrop = Wave.crop;

<*
 Convert wave data to desired format
*>
extern fn void Wave.format(Wave* wave, int sample_rate, int sample_size, int channels) @extern("WaveFormat");
alias waveFormat = Wave.format;

<*
 Load samples data from wave as a 32bit float data array
*>
extern fn float* Wave.loadSamples(Wave wave) @extern("LoadWaveSamples");
alias loadWaveSamples = Wave.loadSamples;

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
extern fn bool Music.isValid(Music music) @extern("IsMusicValid");
alias isMusicValid = Music.isValid;

<*
 Unload music stream
*>
extern fn void Music.unloadStream(Music music) @extern("UnloadMusicStream");
alias unloadMusicStream = Music.unloadStream;

<*
 Start music playing
*>
extern fn void Music.playStream(Music music) @extern("PlayMusicStream");
alias playMusicStream = Music.playStream;

<*
 Check if music is playing
*>
extern fn bool Music.isStreamPlaying(Music music) @extern("IsMusicStreamPlaying");
alias isMusicStreamPlaying = Music.isStreamPlaying;

<*
 Updates buffers for music streaming
*>
extern fn void Music.updateStream(Music music) @extern("UpdateMusicStream");
alias updateMusicStream = Music.updateStream;

<*
 Stop music playing
*>
extern fn void Music.stopStream(Music music) @extern("StopMusicStream");
alias stopMusicStream = Music.stopStream;

<*
 Pause music playing
*>
extern fn void Music.pauseStream(Music music) @extern("PauseMusicStream");
alias pauseMusicStream = Music.pauseStream;

<*
 Resume playing paused music
*>
extern fn void Music.resumeStream(Music music) @extern("ResumeMusicStream");
alias resumeMusicStream = Music.resumeStream;

<*
 Seek music to a position (in seconds)
*>
extern fn void Music.seekStream(Music music, float position) @extern("SeekMusicStream");
alias seekMusicStream = Music.seekStream;

<*
 Set volume for music (1.0 is max level)
 @require volume >= 0.0f && volume <= 1.0f
*>
extern fn void Music.setVolume(Music music, float volume) @extern("SetMusicVolume");
alias setMusicVolume = Music.setVolume;

<*
 Set pitch for a music (1.0 is base level)
 @require pitch >= 0.0f
*>
extern fn void Music.setPitch(Music music, float pitch) @extern("SetMusicPitch");
alias setMusicPitch = Music.setPitch;

<*
 Set pan for a music (0.pan >= 0.0f5 is center)
 @require pan >= 0.0f && pan <= 1.0f
*>
extern fn void Music.setPan(Music music, float pan) @extern("SetMusicPan");
alias setMusicPan = Music.setPan;

<*
 Get music time length (in seconds)
*>
extern fn float Music.getTimeLength(Music music) @extern("GetMusicTimeLength");
alias getMusicTimeLength = Music.getTimeLength;

<*
 Get current music time played (in seconds)
*>
extern fn float Music.getTimePlayed(Music music) @extern("GetMusicTimePlayed");
alias getMusicTimePlayed = Music.getTimePlayed;

// AudioStream management functions
//------------------------------------------------------------------------------------

<*
 Load audio stream (to stream raw audio pcm data)
*>
extern fn AudioStream loadAudioStream(uint sample_rate, uint sample_size, uint channels) @extern("LoadAudioStream");

<*
 Checks if an audio stream is valid (buffers initialized)
*>
extern fn bool AudioStream.isValid(AudioStream stream) @extern("IsAudioStreamValid");
alias isAudioStreamValid = AudioStream.isValid;

<*
 Unload audio stream and free memory
*>
extern fn void AudioStream.unload(AudioStream stream) @extern("UnloadAudioStream");
alias unloadAudioStream = AudioStream.unload;

<*
 Update audio stream buffers with data
*>
extern fn void AudioStream.update(AudioStream stream, void* data, int frame_count) @extern("UpdateAudioStream");
alias updateAudioStream = AudioStream.update;

<*
 Check if any audio stream buffers requires refill
*>
extern fn bool AudioStream.isProcessed(AudioStream stream) @extern("IsAudioStreamProcessed");
alias isAudioStreamProcessed = AudioStream.isProcessed;

<*
 Play audio stream
*>
extern fn void AudioStream.play(AudioStream stream) @extern("PlayAudioStream");
alias playAudioStream = AudioStream.play;

<*
 Pause audio stream
*>
extern fn void AudioStream.pause(AudioStream stream) @extern("PauseAudioStream");
alias pauseAudioStream = AudioStream.pause;

<*
 Resume audio stream
*>
extern fn void AudioStream.resume(AudioStream stream) @extern("ResumeAudioStream");
alias resumeAudioStream = AudioStream.resume;

<*
 Check if audio stream is playing
*>
extern fn bool AudioStream.isPlaying(AudioStream stream) @extern("IsAudioStreamPlaying");
alias isAudioStreamPlaying = AudioStream.isPlaying;

<*
 Stop audio stream
*>
extern fn void AudioStream.stop(AudioStream stream) @extern("StopAudioStream");
alias stopAudioStream = AudioStream.stop;

<*
 Set volume for audio stream (1.0 is max level)
 @require volume >= 0.0f && volume <= 1.0f
*>
extern fn void AudioStream.setVolume(AudioStream stream, float volume) @extern("SetAudioStreamVolume");
alias setAudioStreamVolume = AudioStream.setVolume;

<*
 Set pitch for audio stream (1.0 is base level)
 @require pitch >= 0.0f
*>
extern fn void AudioStream.setPitch(AudioStream stream, float pitch) @extern("SetAudioStreamPitch");
alias setAudioStreamPitch = AudioStream.setPitch;

<*
 Set pan for audio stream (0.5 is centered)
 @require pan >= 0.0f && pan <= 1.0f
*>
extern fn void AudioStream.setPan(AudioStream stream, float pan) @extern("SetAudioStreamPan");
alias setAudioStreamPan = AudioStream.setPan;

<*
 Default size for new audio streams
*>
extern fn void setAudioStreamBufferSizeDefault(int size) @extern("SetAudioStreamBufferSizeDefault");

<*
 Audio thread callback to request new data
*>
extern fn void AudioStream.setCallback(AudioStream stream, AudioCallback callback) @extern("SetAudioStreamCallback");
alias setAudioStreamCallback = AudioStream.setCallback;

<*
 Attach audio stream processor to stream, receives the samples as 'float'
*>
extern fn void AudioStream.attachProcessor(AudioStream stream, AudioCallback processor) @extern("AttachAudioStreamProcessor");
alias attachAudioStreamProcessor = AudioStream.attachProcessor;

<*
 Detach audio stream processor from stream
*>
extern fn void AudioStream.detachProcessor(AudioStream stream, AudioCallback processor) @extern("DetachAudioStreamProcessor");
alias detachAudioStreamProcessor = AudioStream.detachProcessor;

<*
 Attach audio stream processor to the entire audio pipeline, receives the samples as 'float'
*>
extern fn void attachAudioMixedProcessor(AudioCallback processor) @extern("AttachAudioMixedProcessor");

<*
 Detach audio stream processor from the entire audio pipeline
*>
extern fn void detachAudioMixedProcessor(AudioCallback processor) @extern("DetachAudioMixedProcessor");
