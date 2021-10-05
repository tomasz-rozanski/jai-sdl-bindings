// SDL_audio.h

SDL_AUDIOCVT_MAX_FILTERS :: 9;

SDL_MIX_MAXVOLUME :: 128;

SDL_GetAudioDeviceSpec :: (index: s32, iscapture: s32, spec: *SDL_AudioSpec) -> s32 #foreign SDL2;
SDL_LoadWAV_RW :: (src: *SDL_RWops , freesrc: s32, spec: *SDL_AudioSpec, audio_buf: **u8, audio_len: *u32) -> *SDL_AudioSpec #foreign SDL2;
SDL_LoadWAV :: (file: *SDL_AudioSpec, spec: *SDL_AudioSpec, audio_buf: **u8, audio_len: s32) -> *SDL_AudioSpec {
    return SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len);
}

