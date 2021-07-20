#import "SDL";
#import "SDL_bindings";
#import "Basic";

#load "SDL_image.jai";

#if OS == .WINDOWS SDL2_IMAGE :: #foreign_library "win/SDL2_image";

