#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

fragment float4
fragment_colour(vertex_destination interpolated [[stage_in]],
                constant fragment_colour& overlay_color [[buffer(0)]],
                texture2d<float> current_texture [[texture(0)]],
                sampler current_sampler [[sampler(0)]])
{
    float4 texture_color = current_texture.sample(current_sampler, interpolated.texture);
    float alpha = texture_color[3];
    float4 texturecolored;
    
    if(texture_color[0] == 1 && texture_color[1] == 1 && texture_color[2] == 1)
    {
        texturecolored = texture_color;
    }
    else
    {
        texturecolored = float4(overlay_color.red * alpha, overlay_color.green * alpha, overlay_color.blue * alpha, alpha);
    }
    
    return texturecolored;
}
