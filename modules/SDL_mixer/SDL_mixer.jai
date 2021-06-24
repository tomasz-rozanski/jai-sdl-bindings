// Printable format: "%d.%d.%d", MAJOR, MINOR, PATCHLEVEL
SDL_MIXER_MAJOR_VERSION :: 2;
SDL_MIXER_MINOR_VERSION :: 0;
SDL_MIXER_PATCHLEVEL    :: 4;


// This macro can be used to fill a version structure 
// with the compile-time version of the SDL_mixer library.
SDL_MIXER_VERSION :: (X: *SDL_version) {
    X.major = SDL_MIXER_MAJOR_VERSION;
    X.minor = SDL_MIXER_MINOR_VERSION;
    X.patch = SDL_MIXER_PATCHLEVEL;
}

// Backwards compatibility 
MIX_MAJOR_VERSION :: SDL_MIXER_MAJOR_VERSION;
MIX_MINOR_VERSION :: SDL_MIXER_MINOR_VERSION;
MIX_PATCHLEVEL    :: SDL_MIXER_PATCHLEVEL;
MIX_VERSION       :: SDL_MIXER_VERSION;

// This is the version number macro for the current SDL_mixer version.
SDL_MIXER_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_MIXER_MAJOR_VERSION, SDL_MIXER_MINOR_VERSION, SDL_MIXER_PATCHLEVEL);

// This macro will evaluate to true if compiled with SDL_mixer at least X.Y.Z.
SDL_MIXER_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
    return SDL_MIXER_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
}

using MIX_InitFlags :: enum_flags s32 {
    MIX_INIT_FLAC   :: 0x00000001;
    MIX_INIT_MOD    :: 0x00000002;
    MIX_INIT_MP3    :: 0x00000008;
    MIX_INIT_OGG    :: 0x00000010;
    MIX_INIT_MID    :: 0x00000020;
    MIX_INIT_OPUS   :: 0x00000040;
}

// The default mixer has 8 simultaneous mixing channels
MIX_CHANNELS :: 8;

// Good default values for a PC soundcard
MIX_DEFAULT_FREQUENCY :: 22050;
#if SDL_BYTEORDER == SDL_LIL_ENDIAN {
    MIX_DEFAULT_FORMAT :: AUDIO_S16LSB;
} else {
    MIX_DEFAULT_FORMAT :: AUDIO_S16MSB;
}

MIX_DEFAULT_CHANNELS :: 2;
MIX_MAX_VOLUME :: SDL_MIX_MAXVOLUME; // Volume of a chunk

// The internal format for an audio chunk
Mix_Chunk :: struct {
    allocated: s32;
    abuf: *u8;
    alen: u32;
    volume: u8; // Per-sample volume, 0-128
} 

// The different fading types supported
using Mix_Fading :: enum {
    MIX_NO_FADING  :: 0;
    MIX_FADING_OUT :: 1;
    MIX_FADING_IN  :: 2;
}

// These are types of music files (not libraries used to load them)
using Mix_MusicType :: enum {
    MUS_NONE           :: 0;
    MUS_CMD            :: 1;
    MUS_WAV            :: 2;
    MUS_MOD            :: 3;
    MUS_MID            :: 4;
    MUS_OGG            :: 5;
    MUS_MP3            :: 6;
    MUS_MP3_MAD_UNUSED :: 7;
    MUS_FLAC           :: 8;
    MUS_MODPLUG_UNUSED :: 9;
    MUS_OPUS           :: 10;
} 

// The internal format for a music chunk interpreted via mikmod
Mix_Music :: struct {};

// We'll use SDL for reporting errors
Mix_SetError   :: SDL_SetError;
Mix_GetError   :: SDL_GetError;
Mix_ClearError :: SDL_ClearError;

Mix_Linked_Version :: () -> *SDL_version #foreign SDL2_MIXER;
Mix_Init :: (flags: s32) -> s32 #foreign SDL2_MIXER;
Mix_Quit :: ()  #foreign SDL2_MIXER;
Mix_OpenAudio :: (frequency: s32, format: u16, channels: s32, chunksize: s32) -> s32 #foreign SDL2_MIXER;
Mix_OpenAudioDevice :: (frequency: s32, format: u16, channels: s32, chunksize: s32, device: *u8, allowed_changes: s32) -> s32 #foreign SDL2_MIXER;
Mix_AllocateChannels :: (numchans: s32) -> s32 #foreign SDL2_MIXER;
Mix_QuerySpec :: (frequency: *s32, format: *u16, channels: *s32) -> s32 #foreign SDL2_MIXER;
Mix_LoadWAV_RW :: (src: *SDL_RWops, freesrc: s32) -> *Mix_Chunk #foreign SDL2_MIXER;
Mix_LoadWAV :: (file: *SDL_RWops) {
    Mix_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1);
}
Mix_LoadMUS :: (file: *u8) -> *Mix_Music  #foreign SDL2_MIXER;
Mix_LoadMUS_RW :: (src: *SDL_RWops, freesrc: s32) -> *Mix_Music #foreign SDL2_MIXER;
Mix_LoadMUSType_RW :: (src: *SDL_RWops ,  type: Mix_MusicType, freesrc: s32) -> *Mix_Music  #foreign SDL2_MIXER;
Mix_QuickLoad_WAV :: (mem: *u8) -> *Mix_Chunk  #foreign SDL2_MIXER;
Mix_QuickLoad_RAW :: (mem: *u8, len: u32) -> *Mix_Chunk #foreign SDL2_MIXER;
Mix_FreeChunk :: (chunk: *Mix_Chunk) #foreign SDL2_MIXER;
Mix_FreeMusic :: (music: *Mix_Music) #foreign SDL2_MIXER;
Mix_GetNumChunkDecoders :: () -> s32 #foreign SDL2_MIXER;
Mix_GetChunkDecoder :: (index: s32) -> *u8 #foreign SDL2_MIXER;
Mix_HasChunkDecoder :: (name: *u8) -> SDL_bool #foreign SDL2_MIXER;
Mix_GetNumMusicDecoders :: () -> s32 #foreign SDL2_MIXER;
Mix_GetMusicDecoder :: (index: s32) -> *u8 #foreign SDL2_MIXER;
//Mix_HasMusicDecoder :: (name: *u8) -> SDL_bool #foreign SDL2_MIXER;
Mix_GetMusicType :: (music: *Mix_Music) -> Mix_MusicType #foreign SDL2_MIXER;
Mix_SetPostMix :: (mix_func: (udata: *void, stream: *u8, len: s32) -> (), arg: *void) #foreign SDL2_MIXER;
Mix_HookMusic :: (mix_func: (udata: *void, stream: *u8, len: s32) -> (), arg: *void) #foreign SDL2_MIXER;
Mix_HookMusicFinished :: (music_finished: () -> ()) #foreign SDL2_MIXER;
Mix_GetMusicHookData :: () -> *void #foreign SDL2_MIXER;
Mix_ChannelFinished :: (channel_finished: (channel: s32) -> ()) #foreign SDL2_MIXER;

MIX_CHANNEL_POST :: -2;

Mix_EffectFunc_t :: #type (chan: s32, stream: *void, len: s32, udata: *void) -> *void #c_call;
Mix_EffectDone_t :: #type (chan: s32, udata: *void) -> *void #c_call;

Mix_RegisterEffect :: (chan: s32, f: Mix_EffectFunc_t , d: Mix_EffectDone_t , arg: *void) -> s32 #foreign SDL2_MIXER;
Mix_UnregisterEffect :: (channel: s32, f: Mix_EffectFunc_t ) -> s32 #foreign SDL2_MIXER;
Mix_UnregisterAllEffects :: (channel: s32) -> s32 #foreign SDL2_MIXER;

MIX_EFFECTSMAXSPEED  :: "MIX_EFFECTSMAXSPEED";

Mix_SetPanning :: (channel: s32, left: u8, right: u8) -> s32 #foreign SDL2_MIXER;
Mix_SetPosition :: (channel: s32, angle: s16, distance: u8) -> s32 #foreign SDL2_MIXER;
Mix_SetDistance :: (channel: s32, distance: u8) -> s32 #foreign SDL2_MIXER;

#if false {
    Mix_SetReverb :: (channel: s32, echo: u8) -> s32 #foreign SDL2_MIXER;
}

Mix_SetReverseStereo :: (channel: s32, flip: s32) -> s32 #foreign SDL2_MIXER;
Mix_ReserveChannels :: (num: s32) -> s32 #foreign SDL2_MIXER;

Mix_GroupChannel :: (which: s32, tag: s32) -> s32 #foreign SDL2_MIXER;
Mix_GroupChannels :: (from: s32, to: s32, tag: s32) -> s32 #foreign SDL2_MIXER;
Mix_GroupAvailable :: (tag: s32) -> s32 #foreign SDL2_MIXER;
Mix_GroupCount :: (tag: s32) -> s32 #foreign SDL2_MIXER;
Mix_GroupOldest :: (tag: s32) -> s32 #foreign SDL2_MIXER;
Mix_GroupNewer :: (tag: s32) -> s32 #foreign SDL2_MIXER;

Mix_PlayChannelTimed :: (channel: s32, chunk: *Mix_Chunk, loops: s32, ticks: s32) -> s32 #foreign SDL2_MIXER;
Mix_PlayChannel :: (channel: s32, chunk: *Mix_Chunk, loops: s32) -> s32 {
    return Mix_PlayChannelTimed(channel, chunk, loops, -1);
}
Mix_PlayMusic :: (music: *Mix_Music, loops: s32) -> s32 #foreign SDL2_MIXER;

Mix_FadeInMusic :: (music: *Mix_Music , loops: s32, ms: s32) -> s32 #foreign SDL2_MIXER;
Mix_FadeInMusicPos :: (music: *Mix_Music, loops: s32, ms: s32, position: float64) -> s32 #foreign SDL2_MIXER;

Mix_FadeInChannelTimed :: (channel: s32, chunk: *Mix_Chunk, loops: s32, ms: s32, ticks: s32) -> s32 #foreign SDL2_MIXER;
Mix_FadeInChannel :: (channel: s32, chunk: *Mix_Chunk, loops: s32, ms: s32) -> s32 {
    return Mix_FadeInChannelTimed(channel, chunk, loops, ms, -1);
}

Mix_Volume :: (channel: s32, volume: s32) -> s32 #foreign SDL2_MIXER;
Mix_VolumeChunk :: (chunk: *Mix_Chunk, volume: s32) -> s32 #foreign SDL2_MIXER;
Mix_VolumeMusic :: (volume: s32) -> s32 #foreign SDL2_MIXER;

Mix_HaltChannel :: (channel: s32) -> s32 #foreign SDL2_MIXER;
Mix_HaltGroup :: (tag: s32) -> s32 #foreign SDL2_MIXER;
Mix_HaltMusic :: () -> s32 #foreign SDL2_MIXER;

Mix_ExpireChannel :: (channel: s32, ticks: s32) -> s32 #foreign SDL2_MIXER;

Mix_FadeOutChannel :: (which: s32, ms: s32) -> s32 #foreign SDL2_MIXER;
Mix_FadeOutGroup :: (tag: s32, ms: s32) -> s32 #foreign SDL2_MIXER;
Mix_FadeOutMusic :: (ms: s32) -> s32 #foreign SDL2_MIXER;

Mix_FadingMusic :: () -> Mix_Fading  #foreign SDL2_MIXER;
Mix_FadingChannel :: (which: s32) -> Mix_Fading  #foreign SDL2_MIXER;

Mix_Pause :: (channel: s32) #foreign SDL2_MIXER;
Mix_Resume :: (channel: s32) #foreign SDL2_MIXER;
Mix_Paused :: (channel: s32) -> s32 #foreign SDL2_MIXER;

Mix_PauseMusic :: () #foreign SDL2_MIXER;
Mix_ResumeMusic :: () #foreign SDL2_MIXER;
Mix_RewindMusic :: () #foreign SDL2_MIXER;
Mix_PausedMusic :: () -> s32 #foreign SDL2_MIXER;

Mix_SetMusicPosition :: (position: float64) -> s32 #foreign SDL2_MIXER;

Mix_Playing :: (channel: s32) -> s32 #foreign SDL2_MIXER;
Mix_PlayingMusic :: () -> s32 #foreign SDL2_MIXER;

Mix_SetMusicCMD :: (command: *u8) -> s32 #foreign SDL2_MIXER;

Mix_SetSynchroValue :: (value: s32) -> s32 #foreign SDL2_MIXER;
Mix_GetSynchroValue :: () -> s32 #foreign SDL2_MIXER;

Mix_SetSoundFonts :: (paths: *u8) -> s32 #foreign SDL2_MIXER;
Mix_GetSoundFonts :: () -> *u8 #foreign SDL2_MIXER;
Mix_EachSoundFont :: (function: (*u8, *void) -> s32, data: *void) -> s32 #foreign SDL2_MIXER;

Mix_GetChunk :: (channel: s32) -> *Mix_Chunk  #foreign SDL2_MIXER;

Mix_CloseAudio :: () #foreign SDL2_MIXER;

