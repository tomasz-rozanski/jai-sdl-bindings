// Macro to determine SDL version program was compiled against.
//
// This macro fills in a SDL_version structure with the version of the
// library you compiled against. This is determined by what header the
// compiler uses. Note that if you dynamically linked the library, you might
// have a slightly newer or older version at runtime. That version can be
// determined with SDL_GetVersion(), which, unlike SDL_VERSION(),
// is not a macro.
SDL_VERSION :: (X: *SDL_version) {
    X.major = SDL_MAJOR_VERSION;
    X.minor = SDL_MINOR_VERSION;
    X.patch = SDL_PATCHLEVEL;
}

// This is the version number macro for the current SDL version.
SDL_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL);

// This macro will evaluate to true if compiled with SDL at least X.Y.Z.
SDL_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
    return SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
}

// Obsolete function, do not use.
//
// When SDL was hosted in a Mercurial repository, and was built carefully,
// this would return the revision number that the build was created from.
// This number was not reliable for several reasons, but more importantly,
// SDL is now hosted in a git repository, which does not offer numbers at
// all, only hashes. This function only ever returns zero now. Don't use it.
SDL_GetRevisionNumber :: () -> s32 #foreign SDL2 #deprecated "Obsolete. Use SDL_GetRevision instead";

