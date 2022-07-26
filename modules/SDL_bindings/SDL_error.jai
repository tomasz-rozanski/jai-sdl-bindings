// SDL_error.jai

// No idea how to implement this one, so I'll use the oldest trick in the book - ignore it.
//extern DECLSPEC int SDLCALL SDL_SetError(SDL_PRINTF_FORMAT_STRING const char *fmt, ...) SDL_PRINTF_VARARG_FUNC(1);

//SDL_GetError :: () -> *u8 #foreign SDL2;
//SDL_GetErrorMsg :: (errstr: *u8, maxlen: s32) -> *u8 #foreign SDL2;
//SDL_ClearError :: () #foreign SDL2;
SDL_OutOfMemory :: () -> s32 #c_call {
    return SDL_Error(SDL_ENOMEM);
}
SDL_Unsupported :: () => SDL_Error(SDL_UNSUPPORTED);
SDL_InvalidParamError :: (param: $T) -> s32 #c_call {
    return SDL_SetError("Parameter '%s' is invalid", param);
}

using SDL_errorcode :: enum {
    SDL_ENOMEM      :: 1;
    SDL_EFREAD      :: 2;
    SDL_EFWRITE     :: 3;
    SDL_EFSEEK      :: 4;
    SDL_UNSUPPORTED :: 5;
    SDL_LASTERROR   :: 6;
}

SDL_Error :: (code: SDL_errorcode ) -> s32 #foreign SDL2;

