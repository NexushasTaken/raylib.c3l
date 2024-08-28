// vi: ts=4 sw=4
module rl;

//------------------------------------------------------------------------------------
// Audio Loading and Playing Functions (Module: audio)
//------------------------------------------------------------------------------------
def AudioCallback = fn void(void* buffer_data, uint frames);

// Audio device management functions
//------------------------------------------------------------------------------------

/**
 * Initialize audio device and context
 */
extern fn void init_audio_device() @extern("InitAudioDevice");

/**
 * Close the audio device and context
 */
extern fn void close_audio_device() @extern("CloseAudioDevice");

/**
 * Check if audio device has been initialized successfully
 */
extern fn bool is_audio_device_ready() @extern("IsAudioDeviceReady");

/**
 * Set master volume (listener)
 */
extern fn void set_master_volume(float volume) @extern("SetMasterVolume");

/**
 * Get master volume (listener)
 */
extern fn float get_master_volume() @extern("GetMasterVolume");

// Wave/Sound loading/unloading functions
//------------------------------------------------------------------------------------

/**
 * Load wave data from file
 */
extern fn Wave load_wave(ZString file_name) @extern("LoadWave");

/**
 * Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
 */
fn Wave load_wave_from_memory(ZString file_type, char[] file_data) @inline {
    return __load_wave_from_memory(file_type, file_data.ptr, (int)file_data.len);
}

/**
 * Checks if wave data is ready
 */
extern fn bool is_wave_ready(Wave wave) @extern("IsWaveReady");

/**
 * Load sound from file
 */
extern fn Sound load_sound(ZString file_name) @extern("LoadSound");

/**
 * Load sound from wave data
 */
extern fn Sound load_sound_from_wave(Wave wave) @extern("LoadSoundFromWave");

/**
 * Create a new sound that shares the same sample data as the source sound, does not own the sound data
 */
extern fn Sound load_sound_alias(Sound source) @extern("LoadSoundAlias");

/**
 * Checks if a sound is ready
 */
extern fn bool is_sound_ready(Sound sound) @extern("IsSoundReady");

/**
 * Update sound buffer with new data
 */
extern fn void update_sound(Sound sound, void* data, int sample_count) @extern("UpdateSound");

/**
 * Unload wave data
 */
extern fn void unload_wave(Wave wave) @extern("UnloadWave");

/**
 * Unload sound
 */
extern fn void unload_sound(Sound sound) @extern("UnloadSound");

/**
 * Unload a sound alias (does not deallocate sample data)
 */
extern fn void unload_sound_alias(Sound alias) @extern("UnloadSoundAlias");

/**
 * Export wave data to file, returns true on success
 */
extern fn bool export_wave(Wave wave, ZString file_name) @extern("ExportWave");

/**
 * Export wave sample data to code (.h), returns true on success
 */
extern fn bool export_wave_as_code(Wave wave, ZString file_name) @extern("ExportWaveAsCode");

// Wave/Sound management functions
//------------------------------------------------------------------------------------

/**
 * Play a sound
 */
extern fn void play_sound(Sound sound) @extern("PlaySound");

/**
 * Stop playing a sound
 */
extern fn void stop_sound(Sound sound) @extern("StopSound");

/**
 * Pause a sound
 */
extern fn void pause_sound(Sound sound) @extern("PauseSound");

/**
 * Resume a paused sound
 */
extern fn void resume_sound(Sound sound) @extern("ResumeSound");

/**
 * Check if a sound is currently playing
 */
extern fn bool is_sound_playing(Sound sound) @extern("IsSoundPlaying");

/**
 * Set volume for a sound (1.0 is max level)
 */
extern fn void set_sound_volume(Sound sound, float volume) @extern("SetSoundVolume");

/**
 * Set pitch for a sound (1.0 is base level)
 */
extern fn void set_sound_pitch(Sound sound, float pitch) @extern("SetSoundPitch");

/**
 * Set pan for a sound (0.5 is center)
 */
extern fn void set_sound_pan(Sound sound, float pan) @extern("SetSoundPan");

/**
 * Copy a wave to a new wave
 */
extern fn Wave wave_copy(Wave wave) @extern("WaveCopy");

/**
 * Crop a wave to defined samples range
 */
extern fn void wave_crop(Wave* wave, int init_sample, int final_sample) @extern("WaveCrop");

/**
 * Convert wave data to desired format
 */
extern fn void wave_format(Wave* wave, int sample_rate, int sample_size, int channels) @extern("WaveFormat");

/**
 * Load samples data from wave as a 32bit float data array
 */
extern fn float* load_wave_samples(Wave wave) @extern("LoadWaveSamples");

/**
 * Unload samples data loaded with LoadWaveSamples()
 */
extern fn void unload_wave_samples(float* samples) @extern("UnloadWaveSamples");

// Music management functions
//------------------------------------------------------------------------------------

/**
 * Load music stream from file
 */
extern fn Music load_music_stream(ZString file_name) @extern("LoadMusicStream");

/**
 * Load music stream from data
 */
extern fn Music load_music_stream_from_memory(ZString file_type, ZString data, int data_size) @extern("LoadMusicStreamFromMemory");

/**
 * Checks if a music stream is ready
 */
extern fn bool is_music_ready(Music music) @extern("IsMusicReady");

/**
 * Unload music stream
 */
extern fn void unload_music_stream(Music music) @extern("UnloadMusicStream");

/**
 * Start music playing
 */
extern fn void play_music_stream(Music music) @extern("PlayMusicStream");

/**
 * Check if music is playing
 */
extern fn bool is_music_stream_playing(Music music) @extern("IsMusicStreamPlaying");

/**
 * Updates buffers for music streaming
 */
extern fn void update_music_stream(Music music) @extern("UpdateMusicStream");

/**
 * Stop music playing
 */
extern fn void stop_music_stream(Music music) @extern("StopMusicStream");

/**
 * Pause music playing
 */
extern fn void pause_music_stream(Music music) @extern("PauseMusicStream");

/**
 * Resume playing paused music
 */
extern fn void resume_music_stream(Music music) @extern("ResumeMusicStream");

/**
 * Seek music to a position (in seconds)
 */
extern fn void seek_music_stream(Music music, float position) @extern("SeekMusicStream");

/**
 * Set volume for music (1.0 is max level)
 */
extern fn void set_music_volume(Music music, float volume) @extern("SetMusicVolume");

/**
 * Set pitch for a music (1.0 is base level)
 */
extern fn void set_music_pitch(Music music, float pitch) @extern("SetMusicPitch");

/**
 * Set pan for a music (0.5 is center)
 */
extern fn void set_music_pan(Music music, float pan) @extern("SetMusicPan");

/**
 * Get music time length (in seconds)
 */
extern fn float get_music_time_length(Music music) @extern("GetMusicTimeLength");

/**
 * Get current music time played (in seconds)
 */
extern fn float get_music_time_played(Music music) @extern("GetMusicTimePlayed");

// AudioStream management functions
//------------------------------------------------------------------------------------

/**
 * Load audio stream (to stream raw audio pcm data)
 */
extern fn AudioStream load_audio_stream(uint sample_rate, uint sample_size, uint channels) @extern("LoadAudioStream");

/**
 * Checks if an audio stream is ready
 */
extern fn bool is_audio_stream_ready(AudioStream stream) @extern("IsAudioStreamReady");

/**
 * Unload audio stream and free memory
 */
extern fn void unload_audio_stream(AudioStream stream) @extern("UnloadAudioStream");

/**
 * Update audio stream buffers with data
 */
extern fn void update_audio_stream(AudioStream stream, void* data, int frame_count) @extern("UpdateAudioStream");

/**
 * Check if any audio stream buffers requires refill
 */
extern fn bool is_audio_stream_processed(AudioStream stream) @extern("IsAudioStreamProcessed");

/**
 * Play audio stream
 */
extern fn void play_audio_stream(AudioStream stream) @extern("PlayAudioStream");

/**
 * Pause audio stream
 */
extern fn void pause_audio_stream(AudioStream stream) @extern("PauseAudioStream");

/**
 * Resume audio stream
 */
extern fn void resume_audio_stream(AudioStream stream) @extern("ResumeAudioStream");

/**
 * Check if audio stream is playing
 */
extern fn bool is_audio_stream_playing(AudioStream stream) @extern("IsAudioStreamPlaying");

/**
 * Stop audio stream
 */
extern fn void stop_audio_stream(AudioStream stream) @extern("StopAudioStream");

/**
 * Set volume for audio stream (1.0 is max level)
 */
extern fn void set_audio_stream_volume(AudioStream stream, float volume) @extern("SetAudioStreamVolume");

/**
 * Set pitch for audio stream (1.0 is base level)
 */
extern fn void set_audio_stream_pitch(AudioStream stream, float pitch) @extern("SetAudioStreamPitch");

/**
 * Set pan for audio stream (0.5 is centered)
 */
extern fn void set_audio_stream_pan(AudioStream stream, float pan) @extern("SetAudioStreamPan");

/**
 * Default size for new audio streams
 */
extern fn void set_audio_stream_buffer_size_default(int size) @extern("SetAudioStreamBufferSizeDefault");

/**
 * Audio thread callback to request new data
 */
extern fn void set_audio_stream_callback(AudioStream stream, AudioCallback callback) @extern("SetAudioStreamCallback");

/**
 * Attach audio stream processor to stream, receives the samples as <float>s
 */
extern fn void attach_audio_stream_processor(AudioStream stream, AudioCallback processor) @extern("AttachAudioStreamProcessor");

/**
 * Detach audio stream processor from stream
 */
extern fn void detach_audio_stream_processor(AudioStream stream, AudioCallback processor) @extern("DetachAudioStreamProcessor");

/**
 * Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
 */
extern fn void attach_audio_mixed_processor(AudioCallback processor) @extern("AttachAudioMixedProcessor");

/**
 * Detach audio stream processor from the entire audio pipeline
 */
extern fn void detach_audio_mixed_processor(AudioCallback processor) @extern("DetachAudioMixedProcessor");

