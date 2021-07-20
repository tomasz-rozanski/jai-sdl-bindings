
// Printable format: "%d.%d.%d", MAJOR, MINOR, PATCHLEVEL
SDL_IMAGE_MAJOR_VERSION :: 2;
SDL_IMAGE_MINOR_VERSION :: 0;
SDL_IMAGE_PATCHLEVEL    :: 5;

// This macro can be used to fill a version structure with the compile-time
// version of the SDL_image library.
SDL_IMAGE_VERSION :: (X: *SDL_version) {
    X.major = SDL_IMAGE_MAJOR_VERSION;
    X.minor = SDL_IMAGE_MINOR_VERSION;
    X.patch = SDL_IMAGE_PATCHLEVEL;
}

// This is the version number macro for the current SDL_image version.
SDL_IMAGE_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_IMAGE_MAJOR_VERSION, SDL_IMAGE_MINOR_VERSION, SDL_IMAGE_PATCHLEVEL);

 // This macro will evaluate to true if compiled with SDL_image at least X.Y.Z.
 SDL_IMAGE_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
     return SDL_IMAGE_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
 }

// This function gets the version of the dynamically linked SDL_image library.
// it should NOT be used to fill a version structure, instead you should
// use the SDL_IMAGE_VERSION() macro.

IMG_Linked_Version :: () -> *SDL_version #foreign SDL2_IMAGE;

using IMG_InitFlags :: enum_flags s32 {
    IMG_INIT_JPG  :: 0x00000001;
    IMG_INIT_PNG  :: 0x00000002;
    IMG_INIT_TIF  :: 0x00000004;
    IMG_INIT_WEBP :: 0x00000008;
} 

// Loads dynamic libraries and prepares them for use. Flags should be
// one or more flags from IMG_InitFlags OR'd together.
// It returns the flags successfully initialized, or 0 on failure.
IMG_Init :: (flags: s32) -> s32 #foreign SDL2_IMAGE;

// Unloads libraries loaded with IMG_Init */
IMG_Quit :: () #foreign SDL2_IMAGE;

// Load an image from an SDL data source.
// The 'type' may be one of: "BMP", "GIF", "PNG", etc.
 
// If the image format supports a transparent pixel, SDL will set the
// colorkey for the surface. You can enable RLE acceleration on the
// surface afterwards by calling:
// SDL_SetColorKey(image, SDL_RLEACCEL, image->format->colorkey);
IMG_LoadTyped_RW :: (src: *SDL_RWops, freesrc: s32, type: *u8) -> *SDL_Surface #foreign SDL2_IMAGE;

// Convenience functions
IMG_Load :: (file: *u8) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_Load_RW :: (src: *SDL_RWops, freesrc: s32) -> *SDL_Surface #foreign SDL2_IMAGE;

#if SDL_VERSION_ATLEAST(2, 0, 0) {
// Load an image directly into a render texture.
IMG_LoadTexture :: (renderer: *SDL_Renderer, file: *u8) -> *SDL_Texture #foreign SDL2_IMAGE;
IMG_LoadTexture_RW :: (renderer: *SDL_Renderer, src: *SDL_RWops, freesrc: s32) -> *SDL_Texture #foreign SDL2_IMAGE;
IMG_LoadTextureTyped_RW :: (renderer: *SDL_Renderer, src: *SDL_RWops, freesrc: s32, type: *u8) -> *SDL_Texture #foreign SDL2_IMAGE;
}

// Functions to detect a file type, given a seekable source
IMG_isICO :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isCUR :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isBMP :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isGIF :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isJPG :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isLBM :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isPCX :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isPNG :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isPNM :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isSVG :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isTIF :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isXCF :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isXPM :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isXV :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isWEBP :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;

// Individual loading functions
IMG_LoadICO_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadCUR_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadBMP_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadGIF_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadJPG_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadLBM_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadPCX_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadPNG_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadPNM_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadSVG_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadTGA_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadTIF_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadXCF_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadXPM_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadXV_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadWEBP_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;

IMG_ReadXPMFromArray :: (xpm: **u8) -> *SDL_Surface #foreign SDL2_IMAGE;

// Individual saving functions
IMG_SavePNG :: (surface: *SDL_Surface, file: *u8) -> s32 #foreign SDL2_IMAGE;
IMG_SavePNG_RW :: (surface: *SDL_Surface, dst: *SDL_RWops, freedst: s32) -> s32 #foreign SDL2_IMAGE;
IMG_SaveJPG :: (surface: *SDL_Surface, file: *u8, quality: s32) -> s32 #foreign SDL2_IMAGE;
IMG_SaveJPG_RW :: (surface: *SDL_Surface, dst: *SDL_RWops, freedst: s32, quality: s32) -> s32 #foreign SDL2_IMAGE;

// We'll use SDL for reporting errors
IMG_SetError :: SDL_SetError;
IMG_GetError :: SDL_GetError;

// #include "close_code.h"

