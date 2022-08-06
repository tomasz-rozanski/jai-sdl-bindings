// SDL_atomic.jai 

SDL_SpinLock :: s32;

SDL_AtomicTryLock :: (lock: *SDL_SpinLock) -> SDL_bool #foreign SDL2;
SDL_AtomicLock :: (lock: *SDL_SpinLock) #foreign SDL2;
SDL_AtomicUnlock :: (lock: *SDL_SpinLock) #foreign SDL2;
SDL_MemoryBarrierReleaseFunction :: () #foreign SDL2;
SDL_MemoryBarrierAcquireFunction :: () #foreign SDL2;

SDL_atomic_t :: struct {
    value: s32;
}

SDL_AtomicCAS :: (a: *SDL_atomic_t, oldval: s32, newval: s32) -> SDL_bool #foreign SDL2;
SDL_AtomicSet :: (a: *SDL_atomic_t, v: s32) -> s32 #foreign SDL2;
SDL_AtomicGet :: (a: *SDL_atomic_t) -> s32 #foreign SDL2;
SDL_AtomicAdd :: (a: *SDL_atomic_t, v: s32) -> s32 #foreign SDL2;

SDL_AtomicIncRef :: (a: *SDL_atomic_t) -> s32 #c_call {
    return SDL_AtomicAdd(a, 1);
}

SDL_AtomicDecRef :: (a: *SDL_atomic_t) -> SDL_bool #c_call {
    return SDL_AtomicAdd(a, -1) == 1;
}

SDL_AtomicCASPtr :: (a: **void, oldval: *void, newval: *void) -> SDL_bool #foreign SDL2;
SDL_AtomicSetPtr :: (a: **void, v: *void) #foreign SDL2;
SDL_AtomicGetPtr :: (a: **void) #foreign SDL2;

