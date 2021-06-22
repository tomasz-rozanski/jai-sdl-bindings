// SDL_stdinc.h

SDL_reinterpret_cast :: ($T: Type, expression: $A) -> T { 
    result: T = cast,no_check(T) expression; 
    return result;
}

SDL_static_cast :: ($T: Type, expression: $A) -> T { 
    result: T = cast(T) expression; 
    return result;
}

SDL_const_cast :: ($T: Type, $expression: $A) -> T { 
    result: T = cast(T) expression; 
    return result;
}

SDL_FOURCC :: (a: u32, b: u32, c: u32, d: u32) -> u32 {
    result : u32 = ((SDL_static_cast(u32, SDL_static_cast(u8, (a))) << 0) | 
    (SDL_static_cast(u32, SDL_static_cast(u8, (b))) << 8) | 
    (SDL_static_cast(u32, SDL_static_cast(u8, (c))) << 16) | 
    (SDL_static_cast(u32, SDL_static_cast(u8, (d))) << 24));

    return result;
}

