// SDL_pixels.h

// Endianess 
SDL_LIL_ENDIAN :: 1234;
SDL_BIG_ENDIAN :: 4321;

#if LITTLE_ENDIAN == true {
    SDL_BYTEORDER :: SDL_LIL_ENDIAN;
} else {
    SDL_BYTEORDER :: SDL_BIG_ENDIAN;
}

// Transparency definitions
// These define alpha as the opacity of a surface
SDL_ALPHA_OPAQUE      :: 255;
SDL_ALPHA_TRANSPARENT :: 0;

// Pixel type
using SDL_PixelType :: enum u32 {
    SDL_PIXELTYPE_UNKNOWN  :: 0;
    SDL_PIXELTYPE_INDEX1   :: 1;
    SDL_PIXELTYPE_INDEX4   :: 2;
    SDL_PIXELTYPE_INDEX8   :: 3;
    SDL_PIXELTYPE_PACKED8  :: 4;
    SDL_PIXELTYPE_PACKED16 :: 5;
    SDL_PIXELTYPE_PACKED32 :: 6;
    SDL_PIXELTYPE_ARRAYU8  :: 7;
    SDL_PIXELTYPE_ARRAYU16 :: 8;
    SDL_PIXELTYPE_ARRAYU32 :: 9;
    SDL_PIXELTYPE_ARRAYF16 :: 10;
    SDL_PIXELTYPE_ARRAYF32 :: 11;
}

// Bitmap pixel order, high bit -> low bit
using SDL_BitmapOrder :: enum u32 {
    SDL_BITMAPORDER_NONE :: 0;
    SDL_BITMAPORDER_4321 :: 1;
    SDL_BITMAPORDER_1234 :: 2;
}

// Packed component order, high bit -> low bit
using SDL_PackedOrder :: enum u32 {
    SDL_PACKEDORDER_NONE :: 0;
    SDL_PACKEDORDER_XRGB :: 1;
    SDL_PACKEDORDER_RGBX :: 2;
    SDL_PACKEDORDER_ARGB :: 3;
    SDL_PACKEDORDER_RGBA :: 4;
    SDL_PACKEDORDER_XBGR :: 5;
    SDL_PACKEDORDER_BGRX :: 6;
    SDL_PACKEDORDER_ABGR :: 7;
    SDL_PACKEDORDER_BGRA :: 8;
}

// Array component order, low byte -> high byte
using SDL_ArrayOrder :: enum u32 {
    SDL_ARRAYORDER_NONE :: 0;
    SDL_ARRAYORDER_RGB  :: 1;
    SDL_ARRAYORDER_RGBA :: 2;
    SDL_ARRAYORDER_ARGB :: 3;
    SDL_ARRAYORDER_BGR  :: 4;
    SDL_ARRAYORDER_BGRA :: 5;
    SDL_ARRAYORDER_ABGR :: 6;
} 

// Packed component layout
using SDL_PackedLayout :: enum u32 {
    SDL_PACKEDLAYOUT_NONE    :: 0;
    SDL_PACKEDLAYOUT_332     :: 1;
    SDL_PACKEDLAYOUT_4444    :: 2;
    SDL_PACKEDLAYOUT_1555    :: 3;
    SDL_PACKEDLAYOUT_5551    :: 4;
    SDL_PACKEDLAYOUT_565     :: 5;
    SDL_PACKEDLAYOUT_8888    :: 6;
    SDL_PACKEDLAYOUT_2101010 :: 7;
    SDL_PACKEDLAYOUT_1010102 :: 8;
}

SDL_MapRGB :: (format: *SDL_PixelFormat, r: u8, g: u8, b: u8) -> u32 #foreign SDL2;
SDL_MapRGBA :: (format: *SDL_PixelFormat, r: u8, g: u8, b: u8, a: u8) -> u32 #foreign SDL2;

SDL_DEFINE_PIXELFOURCC :: SDL_FOURCC;

SDL_PIXELFLAG :: (x: u32) -> u32 {
    format: u32 = cast(u32) x;
    result := (x >> 28) & 0x0f;
    return result;
}

SDL_PIXELTYPE :: (x: u32) -> u32{
    result := (x >> 24) & 0x0f;
    return result;
}

SDL_PIXELORDER :: (x: u32) -> u32{
    result := (x >> 20) & 0x0f;
    return result;
}

SDL_PIXELLAYOUT :: (x: u32) -> u32{
    result := (x >> 16) & 0x0f;
    return result;
}

SDL_BITSPERPIXEL :: (x: u32) -> u32{
    result := (x >> 8) & 0xff;
    return result;
}

SDL_BYTESPERPIXEL :: (x: u32) -> u32{
    result: u32;
    is_fourcc := SDL_ISPIXELFORMAT_FOURCC(x);

    if is_fourcc == {
        case true;
        if ((x == cast(u32) SDL_PIXELFORMAT_YUY2) || (x == cast(u32) SDL_PIXELFORMAT_UYVY) || (x == cast(u32) SDL_PIXELFORMAT_YVYU)) {
            result = 2;
        } else {
            result = 1;
        }
        case false; 
        result = (x >> 0) & 0xff;
    }

    return result;
}

SDL_ISPIXELFORMAT_INDEXED :: (format: u32) -> bool {
    result := (!SDL_ISPIXELFORMAT_FOURCC(format) && 
    ((SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_INDEX1) || 
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_INDEX4) ||
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_INDEX8)));

    return result;
}

SDL_ISPIXELFORMAT_PACKED :: (format: u32) -> bool {
    result := (!SDL_ISPIXELFORMAT_FOURCC(format) && 
    ((SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_PACKED8) || 
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_PACKED16) || 
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_PACKED32)));

    return result;
}

SDL_ISPIXELFORMAT_ARRAY :: (format: u32) -> bool {
    result := (!SDL_ISPIXELFORMAT_FOURCC(format) && 
    ((SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_ARRAYU8) || 
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_ARRAYU16) ||
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_ARRAYU32) ||
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_ARRAYF16) ||
    (SDL_PIXELTYPE(format) == cast(u32) SDL_PIXELTYPE_ARRAYF32)));

    return result;
}

SDL_ISPIXELFORMAT_ALPHA :: (format: u32) -> bool {
    result := ((SDL_ISPIXELFORMAT_PACKED(format) &&
    ((SDL_PIXELORDER(format) == cast(u32) SDL_PACKEDORDER_ARGB) ||
    (SDL_PIXELORDER(format) == cast(u32) SDL_PACKEDORDER_RGBA) ||
    (SDL_PIXELORDER(format) == cast(u32) SDL_PACKEDORDER_ABGR) ||
    (SDL_PIXELORDER(format) == cast(u32) SDL_PACKEDORDER_BGRA))) || 
    (SDL_ISPIXELFORMAT_ARRAY(format) && 
    ((SDL_PIXELORDER(format) == cast(u32) SDL_ARRAYORDER_ARGB) ||
    (SDL_PIXELORDER(format) == cast(u32) SDL_ARRAYORDER_RGBA) ||
    (SDL_PIXELORDER(format) == cast(u32) SDL_ARRAYORDER_ABGR) ||
    (SDL_PIXELORDER(format) == cast(u32) SDL_ARRAYORDER_BGRA))));

    return result;
}

SDL_ISPIXELFORMAT_FOURCC:: (format: u32) -> bool {
    result := ((format) && (SDL_PIXELFLAG(format) != 1));

    return result;
}

SDL_DEFINE_PIXELFORMAT :: (type: u32, order: u32, layout: u32, bits: u32, bytes: u32) -> u32 {
    return cast(u32) ((1 << 28) | (type << 24) | (order << 20) | (layout << 16) | (bits << 8) | (bytes << 0));
}

using SDL_PixelFormatEnum :: enum u32 {
    SDL_PIXELFORMAT_UNKNOWN;
    SDL_PIXELFORMAT_INDEX1LSB :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_INDEX1, cast(u32) SDL_BITMAPORDER_4321, 0, 1, 0);
    SDL_PIXELFORMAT_INDEX1MSB :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_INDEX1, cast(u32) SDL_BITMAPORDER_1234, 0, 1, 0);
    SDL_PIXELFORMAT_INDEX4LSB :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_INDEX4, cast(u32) SDL_BITMAPORDER_4321, 0, 4, 0);
    SDL_PIXELFORMAT_INDEX4MSB :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_INDEX4, cast(u32) SDL_BITMAPORDER_1234, 0, 4, 0);
    SDL_PIXELFORMAT_INDEX8 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_INDEX8, 0, 0, 8, 1);
    SDL_PIXELFORMAT_RGB332 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED8, cast(u32) SDL_PACKEDORDER_XRGB, cast(u32) SDL_PACKEDLAYOUT_332, 8, 1);
    SDL_PIXELFORMAT_XRGB4444 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_XRGB, cast(u32) SDL_PACKEDLAYOUT_4444, 12, 2);
    SDL_PIXELFORMAT_RGB444 :: SDL_PIXELFORMAT_XRGB4444;
    SDL_PIXELFORMAT_XBGR4444 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_XBGR, cast(u32) SDL_PACKEDLAYOUT_4444, 12, 2);
    SDL_PIXELFORMAT_BGR444 :: SDL_PIXELFORMAT_XBGR4444;
    SDL_PIXELFORMAT_XRGB1555 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_XRGB, cast(u32) SDL_PACKEDLAYOUT_1555, 15, 2);
    SDL_PIXELFORMAT_RGB555 :: SDL_PIXELFORMAT_XRGB1555;
    SDL_PIXELFORMAT_XBGR1555 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_XBGR, cast(u32) SDL_PACKEDLAYOUT_1555, 15, 2);
    SDL_PIXELFORMAT_BGR555 :: SDL_PIXELFORMAT_XBGR1555;
    SDL_PIXELFORMAT_ARGB4444 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_ARGB, cast(u32) SDL_PACKEDLAYOUT_4444, 16, 2);
    SDL_PIXELFORMAT_RGBA4444 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_RGBA, cast(u32) SDL_PACKEDLAYOUT_4444, 16, 2);
    SDL_PIXELFORMAT_ABGR4444 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_ABGR, cast(u32) SDL_PACKEDLAYOUT_4444, 16, 2);
    SDL_PIXELFORMAT_BGRA4444 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_BGRA, cast(u32) SDL_PACKEDLAYOUT_4444, 16, 2);
    SDL_PIXELFORMAT_ARGB1555 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_ARGB, cast(u32) SDL_PACKEDLAYOUT_1555, 16, 2);
    SDL_PIXELFORMAT_RGBA5551 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_RGBA, cast(u32) SDL_PACKEDLAYOUT_5551, 16, 2);
    SDL_PIXELFORMAT_ABGR1555 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_ABGR, cast(u32) SDL_PACKEDLAYOUT_1555, 16, 2);
    SDL_PIXELFORMAT_BGRA5551 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_BGRA, cast(u32) SDL_PACKEDLAYOUT_5551, 16, 2);
    SDL_PIXELFORMAT_RGB565 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_XRGB, cast(u32) SDL_PACKEDLAYOUT_565, 16, 2);
    SDL_PIXELFORMAT_BGR565 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED16, cast(u32) SDL_PACKEDORDER_XBGR, cast(u32) SDL_PACKEDLAYOUT_565, 16, 2);
    SDL_PIXELFORMAT_RGB24 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_ARRAYU8, cast(u32) SDL_ArrayOrder.SDL_ARRAYORDER_RGB, 0, 24, 3);
    SDL_PIXELFORMAT_BGR24 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_ARRAYU8, cast(u32) SDL_ArrayOrder.SDL_ARRAYORDER_BGR, 0, 24, 3);
    SDL_PIXELFORMAT_XRGB8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_XRGB, cast(u32) SDL_PACKEDLAYOUT_8888, 24, 4);
    SDL_PIXELFORMAT_RGB888 :: SDL_PIXELFORMAT_XRGB8888;
    SDL_PIXELFORMAT_RGBX8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_RGBX, cast(u32) SDL_PACKEDLAYOUT_8888, 24, 4);
    SDL_PIXELFORMAT_XBGR8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_XBGR, cast(u32) SDL_PACKEDLAYOUT_8888, 24, 4);
    SDL_PIXELFORMAT_BGR888 :: SDL_PIXELFORMAT_XBGR8888;
    SDL_PIXELFORMAT_BGRX8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_BGRX, cast(u32) SDL_PACKEDLAYOUT_8888, 24, 4);
    SDL_PIXELFORMAT_ARGB8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_ARGB, cast(u32) SDL_PACKEDLAYOUT_8888, 32, 4);
    SDL_PIXELFORMAT_RGBA8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_ARRAYORDER_RGBA, cast(u32) SDL_PACKEDLAYOUT_8888, 32, 4);
    SDL_PIXELFORMAT_ABGR8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_ARRAYORDER_ABGR, cast(u32) SDL_PACKEDLAYOUT_8888, 32, 4);
    SDL_PIXELFORMAT_BGRA8888 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_BGRA, cast(u32) SDL_PACKEDLAYOUT_8888, 32, 4);
    SDL_PIXELFORMAT_ARGB2101010 :: #run SDL_DEFINE_PIXELFORMAT(cast(u32) SDL_PIXELTYPE_PACKED32, cast(u32) SDL_PACKEDORDER_ARGB, cast(u32) SDL_PACKEDLAYOUT_2101010, 32, 4);

    // Aliases for RGBA byte arrays of color data, for the current platform
    #if SDL_BYTEORDER == SDL_BIG_ENDIAN {
        SDL_PIXELFORMAT_RGBA32 :: SDL_PIXELFORMAT_RGBA8888;
        SDL_PIXELFORMAT_ARGB32 :: SDL_PIXELFORMAT_ARGB8888;
        SDL_PIXELFORMAT_BGRA32 :: SDL_PIXELFORMAT_BGRA8888;
        SDL_PIXELFORMAT_ABGR32 :: SDL_PIXELFORMAT_ABGR8888;
    } else {
        SDL_PIXELFORMAT_RGBA32 :: SDL_PIXELFORMAT_ABGR8888;
        SDL_PIXELFORMAT_ARGB32 :: SDL_PIXELFORMAT_BGRA8888;
        SDL_PIXELFORMAT_BGRA32 :: SDL_PIXELFORMAT_ARGB8888;
        SDL_PIXELFORMAT_ABGR32 :: SDL_PIXELFORMAT_RGBA8888;
    }

    // Planar mode: Y + V + U  (3 planes)
    SDL_PIXELFORMAT_YV12 :: #run SDL_DEFINE_PIXELFOURCC(#char "Y", #char "V", #char "1", #char "2");
    // Planar mode: Y + U + V  (3 planes)
    SDL_PIXELFORMAT_IYUV :: #run SDL_DEFINE_PIXELFOURCC(#char "I", #char "Y", #char "U", #char "V");
    // Packed mode: Y0+U0+Y1+V0 (1 plane)
    SDL_PIXELFORMAT_YUY2 :: #run SDL_DEFINE_PIXELFOURCC(#char "Y", #char "U", #char "Y", #char "2");
    // Packed mode: U0+Y0+V0+Y1 (1 plane)
    SDL_PIXELFORMAT_UYVY :: #run SDL_DEFINE_PIXELFOURCC(#char "U", #char "Y", #char "V", #char "Y");
    // Packed mode: Y0+V0+Y1+U0 (1 plane)
    SDL_PIXELFORMAT_YVYU :: #run SDL_DEFINE_PIXELFOURCC(#char "Y", #char "V", #char "Y", #char "U");
    // Planar mode: Y + U/V interleaved  (2 planes)
    SDL_PIXELFORMAT_NV12 :: #run SDL_DEFINE_PIXELFOURCC(#char "N", #char "V", #char "1", #char "2");
    // Planar mode: Y + V/U interleaved  (2 planes)
    SDL_PIXELFORMAT_NV21 :: #run SDL_DEFINE_PIXELFOURCC(#char "N", #char "V", #char "2", #char "1");
    // Android video texture format
    SDL_PIXELFORMAT_EXTERNAL_OES :: #run SDL_DEFINE_PIXELFOURCC(#char "O", #char "E", #char "S", #char " ");
}

// Testing procedures
test_pixels_pixel_formats :: () {
    print("\n=== Test SDL_PIXELFORMAT values ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: 0x%\n", it, formatInt(info.values[it_index], 16, 8));
    }
}

test_pixels_pixel_flag :: () {
    print("\n=== Test SDL_PIXELFLAG ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_PIXELFLAG(cast(u32)info.values[it_index]));
    }
}

test_pixels_pixel_type :: () {
    print("\n=== Test SDL_PIXELTYPE ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_PIXELTYPE(cast(u32)info.values[it_index]));
    }
}

test_pixels_pixel_order :: () {
    print("\n=== Test SDL_PIXELORDER ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_PIXELORDER(cast(u32)info.values[it_index]));
    }
}

test_pixels_pixel_layout :: () {
    print("\n=== Test SDL_PIXELLAYOUT ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_PIXELLAYOUT(cast(u32)info.values[it_index]));
    }
}

test_pixels_bits_per_pixel :: () {
    print("\n=== Test SDL_BITSPERPIXEL ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_BITSPERPIXEL(cast(u32)info.values[it_index]));
    }
}

test_pixels_bytes_per_pixel :: () {
    print("\n=== Test SDL_BYTESPERPIXEL ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_BYTESPERPIXEL(cast(u32)info.values[it_index]));
    }
}

test_pixels_ispixelformat_indexed:: () {
    print("\n=== Test SDL_ISPIXELFORMAT_INDEXED ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_ISPIXELFORMAT_INDEXED(cast(u32)info.values[it_index]));
    }
}

test_pixels_ispixelformat_packed :: () {
    print("\n=== Test SDL_ISPIXELFORMAT_PACKED ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_ISPIXELFORMAT_PACKED(cast(u32)info.values[it_index]));
    }
}

test_pixels_ispixelformat_array :: () {
    print("\n=== Test SDL_ISPIXELFORMAT_ARRAY ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_ISPIXELFORMAT_ARRAY(cast(u32)info.values[it_index]));
    }
}

test_pixels_ispixelformat_alpha :: () {
    print("\n=== Test SDL_ISPIXELFORMAT_ALPHA ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_ISPIXELFORMAT_ALPHA(cast(u32)info.values[it_index]));
    }
}

test_pixels_ispixelformat_fourcc :: () {
    print("\n=== Test SDL_ISPIXELFORMAT_FOURCC ===\n");

    info := cast(*Type_Info_Enum) SDL_PixelFormatEnum;

    for info.names {
        print("% :: %\n", it, SDL_ISPIXELFORMAT_FOURCC(cast(u32)info.values[it_index]));
    }
}

test_pixels_module :: () {
    test_pixels_pixel_formats();
    test_pixels_pixel_flag();
    test_pixels_pixel_type();
    test_pixels_pixel_order();
    test_pixels_pixel_layout();
    test_pixels_bits_per_pixel();
    test_pixels_bytes_per_pixel();
    test_pixels_ispixelformat_indexed();
    test_pixels_ispixelformat_packed();
    test_pixels_ispixelformat_array();
    test_pixels_ispixelformat_alpha();
    test_pixels_ispixelformat_fourcc();
}

//#run test_pixels_module();
