#import "SDL";
#import "SDL_bindings";
#import "Basic";

#load "SDL_mixer.jai";

#if OS == .WINDOWS SDL2_MIXER :: #foreign_library "win/SDL2_mixer";

#module_parameters(LITTLE_ENDIAN := true);

// Endianess 
SDL_LIL_ENDIAN :: 1234;
SDL_BIG_ENDIAN :: 4321;

#if LITTLE_ENDIAN == true {
    SDL_BYTEORDER :: SDL_LIL_ENDIAN;
} else {
    SDL_BYTEORDER :: SDL_BIG_ENDIAN;
}

