// RWops Types
SDL_RWOPS_UNKNOWN   : u32 : 0;
SDL_RWOPS_WINFILE   : u32 : 1;
SDL_RWOPS_STDFILE   : u32 : 2;
SDL_RWOPS_JNIFILE   : u32 : 3;
SDL_RWOPS_MEMORY    : u32 : 4;
SDL_RWOPS_MEMORY_RO : u32 : 5;

// This is the read/write operation structure -- very basic.

/* Already implemented in SDL_surface.jai
SDL_RWops :: struct {
    size :: #type (*SDL_RWops) -> s64;
    seek :: #type (SDL_RWops, s64, s32) -> s64;
    read :: #type (SDL_RWops, *void, int, int) -> int;
    write :: #type (SDL_RWops, *void, int, int) -> int;
    close :: #type (SDL_RWops) -> s32;

    type: u32;

    hidden :: union {
        #if OS == .WINDOWS {
            windowsio :: struct {
                append: SDL_bool;
                h: *void;
                buffer :: struct {
                    data: *void;
                    size: int;
                    left: int;
                }
            }
        }

        mem :: struct {
            base: *u8;
            here: *u8;
            stop: *u8;
        }

        unknown :: struct {
            data1: *void;
            data2: *void;
        }
    }
}

// Functions to create SDL_RWops structures from various data streams.
//SDL_RWFromFile :: (file: *u8, mode: *u8) -> *SDL_RWops #foreign SDL2;
*/

//#ifdef HAVE_STDIO_H
//SDL_RWFromFP :: (fp: *FILE, autoclose: SDL_bool ) -> *SDL_RWops #foreign SDL2;
//#else
SDL_RWFromFP :: (fp: *void, autoclose: SDL_bool) -> *SDL_RWops #foreign SDL2;

SDL_RWFromMem :: (mem: *void, size: s32) -> *SDL_RWops #foreign SDL2;
SDL_RWFromConstMem :: (mem: *void, size: s32) -> *SDL_RWops #foreign SDL2;

// RWFrom functions
SDL_AllocRW :: () -> *SDL_RWops #foreign SDL2;
SDL_FreeRW :: (area: *SDL_RWops) #foreign SDL2;

RW_SEEK_SET :: 0;
RW_SEEK_CUR :: 1;
RW_SEEK_END :: 2;

SDL_RWsize :: (_context: *SDL_RWops) -> s64 #foreign SDL2;
SDL_RWseek :: (_context: *SDL_RWops, offset: s64, whence: s32) -> s64 #foreign SDL2;
SDL_RWtell :: (_context: *SDL_RWops) -> s64 #foreign SDL2;

SDL_RWread :: (_context: *SDL_RWops, ptr: *void, size: int, maxnum: int) -> int #foreign SDL2;
SDL_RWwrite :: (_context: *SDL_RWops, ptr: *void, size: int, num: int) -> int #foreign SDL2;
SDL_RWclose :: (_context: *SDL_RWops) -> s32 #foreign SDL2;

SDL_LoadFile_RW :: (src: *SDL_RWops, datasize: *int, freesrc: s32) #foreign SDL2;
SDL_LoadFile :: (file: *u8, datasize: *int) #foreign SDL2;

SDL_ReadU8 :: (src: *SDL_RWops) -> u8 #foreign SDL2;
SDL_ReadLE16 :: (src: *SDL_RWops) -> u16 #foreign SDL2;
SDL_ReadBE16 :: (src: *SDL_RWops) -> u16 #foreign SDL2;
SDL_ReadLE32 :: (src: *SDL_RWops) -> u32 #foreign SDL2;
SDL_ReadBE32 :: (src: *SDL_RWops) -> u32 #foreign SDL2;
SDL_ReadLE64 :: (src: *SDL_RWops) -> u64 #foreign SDL2;
SDL_ReadBE64 :: (src: *SDL_RWops) -> u64 #foreign SDL2;

SDL_WriteU8 :: (dst: *SDL_RWops, value: u8) -> int #foreign SDL2;
SDL_WriteLE16 :: (dst: *SDL_RWops, value: u16) -> int #foreign SDL2;
SDL_WriteBE16 :: (dst: *SDL_RWops, value: u16) -> int #foreign SDL2;
SDL_WriteLE32 :: (dst: *SDL_RWops, value: u32) -> int #foreign SDL2;
SDL_WriteBE32 :: (dst: *SDL_RWops, value: u32) -> int #foreign SDL2;
SDL_WriteLE64 :: (dst: *SDL_RWops, value: u64) -> int #foreign SDL2;
SDL_WriteBE64 :: (dst: *SDL_RWops, value: u64) -> int #foreign SDL2;

