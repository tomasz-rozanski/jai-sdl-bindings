#import "SDL";
#import "SDL_bindings";
#import "Basic";

#load "SDL_ttf.jai";

#if OS == .WINDOWS SDL2_TTF :: #foreign_library "win/SDL2_ttf";

