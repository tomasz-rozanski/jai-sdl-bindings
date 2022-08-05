// SDL_version.jai

SDL_VERSION :: (X: *SDL_version) {
    X.major = SDL_MAJOR_VERSION;
    X.minor = SDL_MINOR_VERSION;
    X.patch = SDL_PATCHLEVEL;
}

SDL_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL);

SDL_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
    return SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
}

SDL_GetRevisionNumber :: () -> s32 #foreign SDL2 #deprecated "Obsolete. Use SDL_GetRevision instead";

