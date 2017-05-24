#include <metal_stdlib>

using namespace metal;
#include "MetalShaderStructs.h"

static constant float destination_position = 1;
static constant float coord_z = 0;

vertex vertex_destination
vertex_textured(constant vertex_source* vertex_array [[buffer(0)]],
                constant projection_matrix& projection [[buffer(1)]],
                constant position_matrix& position [[buffer(2)]],
                constant rotation_matrix& rotation [[buffer(3)]],
                unsigned int vid [[vertex_id]])
{
    vertex_source source = vertex_array[vid];
    vertex_destination destination;
    
    float2 coords_rotated = source.coords * rotation.rotate;
    float coords_x = coords_rotated[0];
    float coords_y = coords_rotated[1];
    
    float projected_x = coords_x / projection.project_width;
    float projected_y = coords_y / projection.project_height;
    
    float move_projected_x = position.move_x / projection.project_width;
    float move_projected_y = position.move_y / projection.project_height;
    
    float final_x = projected_x + move_projected_x;
    float final_y = projected_y + move_projected_y;
    
    float4 coords = float4(final_x, final_y, coord_z, destination_position);
    
    destination.coords = coords;
    destination.texture = source.texture;
    
    return destination;
}
