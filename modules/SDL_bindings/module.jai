#import "SDL";
#import "Basic";

#load "SDL_audio.jai";
#load "SDL_error.jai";
#load "SDL_haptic.jai";
#load "SDL_pixels.jai";
#load "SDL_stdinc.jai";
#load "SDL_surface.jai";
#load "SDL_version.jai";

// Ignore endiness for now
//#module_parameters(LITTLE_ENDIAN := true);

// Some utilities for testing procedures.

// Query procedure name
current_proc_name :: () -> string {
     return context.stack_trace.info.name;
}

// Terminal codes for text coloring
RED :: "\e[31m";
GREEN :: "\e[32m";
YELLOW :: "\e[93m";
CYAN :: "\e[36m";
NORMAL :: "\e[0m";

