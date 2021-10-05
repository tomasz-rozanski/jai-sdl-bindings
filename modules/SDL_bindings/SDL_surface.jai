// SDL_surface.h
SDL_UpperBlit :: (src: *SDL_Surface, srcrect: *SDL_Rect, dst: *SDL_Surface, dstrect: *SDL_Rect) -> s32 #foreign SDL2;
SDL_BlitSurface :: SDL_UpperBlit; 
SDL_SetColorKey :: (surface: *SDL_Surface, flag: int, key: u32) -> s32 #foreign SDL2; 

SDL_ConvertSurface :: (src: *SDL_Surface, fmt: *SDL_PixelFormat, flags: u32) -> *SDL_Surface #foreign SDL2;

SDL_SoftStretchLinear :: (src: *SDL_Surface, srcrect: *SDL_Rect, dst: *SDL_Surface, dstrect: *SDL_Rect) -> s32 #foreign SDL2;

