// SDL_image.jai

SDL_IMAGE_MAJOR_VERSION :: 2;
SDL_IMAGE_MINOR_VERSION :: 0;
SDL_IMAGE_PATCHLEVEL    :: 5;

SDL_IMAGE_VERSION :: (X: *SDL_version) {
    X.major = SDL_IMAGE_MAJOR_VERSION;
    X.minor = SDL_IMAGE_MINOR_VERSION;
    X.patch = SDL_IMAGE_PATCHLEVEL;
}

SDL_IMAGE_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_IMAGE_MAJOR_VERSION, SDL_IMAGE_MINOR_VERSION, SDL_IMAGE_PATCHLEVEL);

 SDL_IMAGE_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
     return SDL_IMAGE_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
 }

IMG_Linked_Version :: () -> *SDL_version #foreign SDL2_IMAGE;

using IMG_InitFlags :: enum_flags s32 {
    IMG_INIT_JPG  :: 0x00000001;
    IMG_INIT_PNG  :: 0x00000002;
    IMG_INIT_TIF  :: 0x00000004;
    IMG_INIT_WEBP :: 0x00000008;
} 

IMG_Init :: (flags: s32) -> s32 #foreign SDL2_IMAGE;

IMG_Quit :: () #foreign SDL2_IMAGE;

IMG_LoadTyped_RW :: (src: *SDL_RWops, freesrc: s32, type: *u8) -> *SDL_Surface #foreign SDL2_IMAGE;

IMG_Load :: (file: *u8) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_Load_RW :: (src: *SDL_RWops, freesrc: s32) -> *SDL_Surface #foreign SDL2_IMAGE;

#if #run SDL_VERSION_ATLEAST(2, 0, 0) {
IMG_LoadTexture :: (renderer: *SDL_Renderer, file: *u8) -> *SDL_Texture #foreign SDL2_IMAGE;
IMG_LoadTexture_RW :: (renderer: *SDL_Renderer, src: *SDL_RWops, freesrc: s32) -> *SDL_Texture #foreign SDL2_IMAGE;
IMG_LoadTextureTyped_RW :: (renderer: *SDL_Renderer, src: *SDL_RWops, freesrc: s32, type: *u8) -> *SDL_Texture #foreign SDL2_IMAGE;
}

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

IMG_SavePNG :: (surface: *SDL_Surface, file: *u8) -> s32 #foreign SDL2_IMAGE;
IMG_SavePNG_RW :: (surface: *SDL_Surface, dst: *SDL_RWops, freedst: s32) -> s32 #foreign SDL2_IMAGE;
IMG_SaveJPG :: (surface: *SDL_Surface, file: *u8, quality: s32) -> s32 #foreign SDL2_IMAGE;
IMG_SaveJPG_RW :: (surface: *SDL_Surface, dst: *SDL_RWops, freedst: s32, quality: s32) -> s32 #foreign SDL2_IMAGE;

// IMG_SetError :: SDL_SetError; // @not_implemented
IMG_GetError :: SDL_GetError;

IMG_Animation :: struct {
    w, h: s32;
    count: s32;
    frames: **SDL_Surface;
    delays: *s32;
} 

IMG_FreeAnimation :: (anim: *IMG_Animation) #foreign SDL2_IMAGE;
IMG_isAVIF :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isJXL :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_isQOI :: (src: *SDL_RWops) -> s32 #foreign SDL2_IMAGE;
IMG_LoadAnimation :: (file: *u8) -> *IMG_Animation #foreign SDL2_IMAGE;
IMG_LoadAnimation_RW :: (src: *SDL_RWops, freesrc: s32) -> *IMG_Animation #foreign SDL2_IMAGE;
IMG_LoadAnimationTyped_RW :: (src: *SDL_RWops, freesrc: s32, type: *u8) -> *IMG_Animation #foreign SDL2_IMAGE;
IMG_LoadAVIF_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadGIFAnimation_RW :: (src: *SDL_RWops) -> *IMG_Animation #foreign SDL2_IMAGE;
IMG_LoadJXL_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadQOI_RW :: (src: *SDL_RWops) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_LoadSizedSVG_RW :: (src: *SDL_RWops, width: s32, height: s32) -> *SDL_Surface #foreign SDL2_IMAGE;
IMG_ReadXPMFromArrayToRGB888 :: (xpm: **u8) -> *SDL_Surface #foreign SDL2_IMAGE;

