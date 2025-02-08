shader_type spatial;

// PREPROCESSOR DIRECTIVES

// Contains layer numbers and some common functions
#include "res://shaders/globals.gdshaderinc"

varying uint camera_layers;

void fragment()
{
	camera_layers = CAMERA_VISIBLE_LAYERS;

	//ALPHA=1.;

	// Use emission to render the depth value
	if (camera_layers == DEPTH_LAYER)
	{
		//ALBEDO = vec3(0.0);
		float depth = transform_position(PROJECTION_MATRIX, VERTEX).z;
		vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
		vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
  		view.xyz /= view.w;
  		float linear_depth = -view.z;
		EMISSION.x = linear_depth;
		EMISSION.y = 0.;
		EMISSION.z = 0.;
	}
	else if (camera_layers == NORMAL_LAYER)
	{
		ALBEDO = vec3(0.0);
		EMISSION = 0.5 * (NORMAL + vec3(1.0));
	}
	else
	{
		ALBEDO = vec3(1.);
		//ALPHA = 1.;
	}
}