// SDL_ttf.jai

SDL_TTF_MAJOR_VERSION :: 2;
SDL_TTF_MINOR_VERSION :: 0;
SDL_TTF_PATCHLEVEL    :: 15;

SDL_TTF_VERSION :: (X: *SDL_version) {
    X.major = SDL_TTF_MAJOR_VERSION;
    X.minor = SDL_TTF_MINOR_VERSION;
    X.patch = SDL_TTF_PATCHLEVEL;
}

TTF_MAJOR_VERSION :: SDL_TTF_MAJOR_VERSION;
TTF_MINOR_VERSION :: SDL_TTF_MINOR_VERSION;
TTF_PATCHLEVEL    :: SDL_TTF_PATCHLEVEL;
TTF_VERSION       :: SDL_TTF_VERSION;

SDL_TTF_COMPILEDVERSION :: #run SDL_VERSIONNUM(SDL_TTF_MAJOR_VERSION, SDL_TTF_MINOR_VERSION, SDL_TTF_PATCHLEVEL);

SDL_TTF_VERSION_ATLEAST :: (X: s32, Y: s32, Z: s32) -> bool {
    return SDL_TTF_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z);
}

SDL_DEPRECATED :: 1;

TTF_Linked_Version:: () -> *SDL_version #foreign SDL2_TTF; 

UNICODE_BOM_NATIVE  :: 0xfeff;
UNICODE_BOM_SWAPPED :: 0xfffe;

TTF_ByteSwappedUNICODE :: (swapped: s32) #foreign SDL2_TTF; 

TTF_Font :: struct {};

TTF_Init :: () -> s32 #foreign SDL2_TTF; 

TTF_OpenFont :: (file: *u8, ptsize: s32) -> *TTF_Font #foreign SDL2_TTF; 
TTF_OpenFontIndex :: (file: *u8, ptsize: s32, index: s64) -> *TTF_Font #foreign SDL2_TTF;
TTF_OpenFontRW :: (src: *SDL_RWops, freesrc: s32, ptsize: s32) -> *TTF_Font #foreign SDL2_TTF; 
TTF_OpenFontIndexRW :: (src: *SDL_RWops, freesrc: s32, ptsize: s32, index: s64) -> *TTF_Font #foreign SDL2_TTF; 

TTF_STYLE_NORMAL        :: 0x00;
TTF_STYLE_BOLD          :: 0x01;
TTF_STYLE_ITALIC        :: 0x02;
TTF_STYLE_UNDERLINE     :: 0x04;
TTF_STYLE_STRIKETHROUGH :: 0x08;

TTF_GetFontStyle :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontStyle :: (font: *TTF_Font, style: s32) #foreign SDL2_TTF; 
TTF_GetFontOutline :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontOutline :: (font: *TTF_Font, outline: s32) #foreign SDL2_TTF; 

TTF_HINTING_NORMAL :: 0;
TTF_HINTING_LIGHT  :: 1;
TTF_HINTING_MONO   :: 2;
TTF_HINTING_NONE   :: 3;

TTF_GetFontHinting :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontHinting :: (font: *TTF_Font, hinting: s32) #foreign SDL2_TTF; 

TTF_FontHeight :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

TTF_FontAscent :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

TTF_FontDescent :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

TTF_FontLineSkip :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 

TTF_GetFontKerning :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_SetFontKerning :: (font: *TTF_Font, allowed: s32) #foreign SDL2_TTF; 

TTF_FontFaces :: (font: *TTF_Font) -> s64 #foreign SDL2_TTF; 

TTF_FontFaceIsFixedWidth :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF; 
TTF_FontFaceFamilyName :: (font: *TTF_Font) -> *u8 #foreign SDL2_TTF; 
TTF_FontFaceStyleName :: (font: *TTF_Font) -> *u8 #foreign SDL2_TTF; 

TTF_GlyphIsProvided :: (font: *TTF_Font, ch: u16) -> s32 #foreign SDL2_TTF; 

TTF_GlyphMetrics :: (font: *TTF_Font, ch: u16, minx: *s32, maxx: *s32, miny: *s32, maxy: *s32, advance: *s32) -> s32 #foreign SDL2_TTF; 

TTF_SizeText :: (font: *TTF_Font, text: *u8, w: *s32, h: *s32) -> s32 #foreign SDL2_TTF; 
TTF_SizeUTF8 :: (font: *TTF_Font, text: *u8, w: *s32, h: *s32) -> s32 #foreign SDL2_TTF; 
TTF_SizeUNICODE :: (font: *TTF_Font, text: *u16, w: *s32, h: *s32) -> s32 #foreign SDL2_TTF; 

TTF_RenderText_Solid :: (font: *TTF_Font, text: *u8, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Solid :: (font: *TTF_Font, text: *u8, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Solid :: (font: *TTF_Font, text: *u16, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderGlyph_Solid :: (font: *TTF_Font, ch: u16, fg: SDL_Color ) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderText_Shaded :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Shaded :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Shaded :: (font: *TTF_Font, text: *u16, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderGlyph_Shaded :: (font: *TTF_Font, ch: u16, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderText_Blended :: (font: *TTF_Font, text: *u8, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Blended :: (font: *TTF_Font, text: *u8, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Blended :: (font: *TTF_Font, text: *u16, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderText_Blended_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUTF8_Blended_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF; 
TTF_RenderUNICODE_Blended_Wrapped :: (font: *TTF_Font, text: *u16, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderGlyph_Blended :: (font: *TTF_Font, ch: u16, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF; 

TTF_RenderText :: TTF_RenderText_Shaded;
TTF_RenderUTF8 :: TTF_RenderUTF8_Shaded;
TTF_RenderUNICODE :: TTF_RenderUNICODE_Shaded;

TTF_CloseFont :: (font: *TTF_Font) #foreign SDL2_TTF; 

TTF_Quit :: () #foreign SDL2_TTF; 

TTF_WasInit :: () -> s32 #foreign SDL2_TTF; 

TTF_GetFontKerningSize :: (font: *TTF_Font, prev_index: s32, index: s32) -> s32 #deprecated "Use TTF_GetFontKerningSizeGlyphs instead" #foreign SDL2_TTF; 

TTF_GetFontKerningSizeGlyphs :: (font: *TTF_Font, previous_ch: u16, ch: u16) -> s32 #foreign SDL2_TTF; 

// TTF_SetError :: SDL_SetError; // @todo uncomment, once SDL_SetError is implemented
TTF_GetError :: SDL_GetError;

TTF_GetFontWrappedAlign :: (font: *TTF_Font) -> s32 #foreign SDL2_TTF;

TTF_GetFreeTypeVersion :: (major: *s32, minor: *s32, patch: *s32) #foreign SDL2_TTF;
TTF_GetHarfBuzzVersion :: (major: *s32, minor: *s32, patch: *s32) #foreign SDL2_TTF;

TTF_GlyphIsProvided32 :: (font: *TTF_Font, ch: u32) -> s32 #foreign SDL2_TTF;
TTF_GlyphMetrics32 :: (font: *TTF_Font, ch: u32, minx: *s32, maxx: *s32, miny: *s32, maxy: *s32, advance: *s32) -> s32 #foreign SDL2_TTF;

TTF_MeasureText :: (font: *TTF_Font, text: *u8, measure_width: s32, extent: *s32, count: *s32) -> s32 #foreign SDL2_TTF;
TTF_MeasureUNICODE :: (font: *TTF_Font, text: *u16, measure_width: s32, extent: *s32, count: *s32) -> s32 #foreign SDL2_TTF;
TTF_MeasureUTF8 :: (font: *TTF_Font, text: *u8, measure_width: s32, extent: *s32, count: *s32) -> s32 #foreign SDL2_TTF;

TTF_OpenFontDPI :: (file: *u8, ptsize: s32, hdpi: u32, vdpi: u32) -> *TTF_Font #foreign SDL2_TTF;
TTF_OpenFontDPIRW :: (src: *SDL_RWops, freesrc: s32, ptsize: s32, hdpi: u32, vdpi: u32) -> *TTF_Font #foreign SDL2_TTF;

TTF_OpenFontIndexDPI :: (file: *u8, ptsize: s32, index: s64, hdpi: u32, vdpi: u32) -> *TTF_Font #foreign SDL2_TTF;
TTF_OpenFontIndexDPIRW :: (src: *SDL_RWops, freesrc: s32, ptsize: s32, index: s64, hdpi: u32, vdpi: u32) -> *TTF_Font #foreign SDL2_TTF;

TTF_RenderGlyph32_Blended :: (font: *TTF_Font, ch: u32, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderGlyph32_LCD :: (font: *TTF_Font, ch: u32, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderGlyph32_Shaded :: (font: *TTF_Font, ch: u32, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderGlyph32_Solid :: (font: *TTF_Font, ch: u32, fg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;

TTF_RenderGlyph_LCD :: (font: *TTF_Font, ch: u16, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderText_LCD :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderText_LCD_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderText_Shaded_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderText_Solid_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;

TTF_RenderUNICODE_LCD :: (font: *TTF_Font, text: *u16, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderUNICODE_LCD_Wrapped :: (font: *TTF_Font, text: *u16, fg: SDL_Color, bg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderUNICODE_Shaded_Wrapped :: (font: *TTF_Font, text: *u16, fg: SDL_Color, bg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderUNICODE_Solid_Wrapped :: (font: *TTF_Font, text: *u16, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;

TTF_RenderUTF8_LCD :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderUTF8_LCD_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderUTF8_Shaded_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, bg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;
TTF_RenderUTF8_Solid_Wrapped :: (font: *TTF_Font, text: *u8, fg: SDL_Color, wrapLength: u32) -> *SDL_Surface #foreign SDL2_TTF;

using TTF_Direction :: enum {
    TTF_DIRECTION_LTR;
    TTF_DIRECTION_RTL;
    TTF_DIRECTION_TTB;
    TTF_DIRECTION_BTT;
}

TTF_SetDirection :: (direction: s32) -> s32 #foreign SDL2_TTF;
TTF_SetFontDirection :: (font: *TTF_Font, direction: TTF_Direction ) -> s32 #foreign SDL2_TTF;
TTF_SetFontScriptName :: (font: *TTF_Font, script: *u8) -> s32 #foreign SDL2_TTF;
TTF_SetFontSize :: (font: *TTF_Font, ptsize: s32) -> s32 #foreign SDL2_TTF;
TTF_SetFontSizeDPI :: (font: *TTF_Font, ptsize: s32, hdpi: u32, vdpi: u32) -> s32 #foreign SDL2_TTF;
TTF_SetFontWrappedAlign :: (font: *TTF_Font, align: s32) #foreign SDL2_TTF;
TTF_SetScript :: (script: s32) -> s32 #foreign SDL2_TTF;

