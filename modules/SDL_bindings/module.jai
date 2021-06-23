#import "SDL";
#import "Basic";

#load "SDL_haptic.jai";
#load "SDL_pixels.jai";
#load "SDL_stdinc.jai";
#load "SDL_surface.jai";

#module_parameters(LITTLE_ENDIAN := true);


// Some utility stuff for testing. Please ignore

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

