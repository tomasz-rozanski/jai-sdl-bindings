#import "SDL";
#import "SDL_bindings";
#import "Basic";

#load "SDL_mixer.jai";

#if OS == .WINDOWS {
    SDL2_MIXER :: #foreign_library "win/SDL2_mixer";
} else #if OS == .LINUX {
    SDL2_MIXER :: #foreign_library "linux/libSDL2_mixer";
}

