/**
 * object_shader.gdshaderinc
 *
 * Part of the monolithic approach to object shaders.
 *
 * This shader include file is used by both "opaque_shader.gdshader" and
 * "transparent_shader.gdshader". Since rendering opaque and transparent objects is almost exactly
 * the same (except for writing to ALPHA), it makes sense to consolidate the shared code in a single
 * file.
 *
 * This shader handles rendering on all of the different layers in both the fragment() and light()
 * functions. If on the depth layer, it renders depth info. If on the normal layer, it renders
 * normal info. Otherwise, if on the color layer, it renders the color based on a uniform that has
 * been passed in.
 */



// PREPROCESSOR DIRECTIVES

// Contains layer numbers and some common functions
#include "res://shaders/globals.gdshaderinc"

// Common hints for uniform textures.
#define hint_texture filter_nearest_mipmap, repeat_enable



// UNIFORMS

/** The material's base color. */
uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);



// VARYINGS

// The layer(s) of the current camera.
varying uint camera_layers;



// FUNCTIONS

// Called once for every pixel.
void fragment()
{
	camera_layers = CAMERA_VISIBLE_LAYERS;

	// Use emission to render the depth value
	if (camera_layers == DEPTH_LAYER)
	{


		ALBEDO = vec3(0.0);
		float depth = transform_position(PROJECTION_MATRIX, VERTEX).z;
		vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
		vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
  		view.xyz /= view.w;
  		float linear_depth = -view.z;
		//EMISSION.x = linear_depth / 10.;
		EMISSION.x = 1. - depth;
		EMISSION.y = 0.;
		EMISSION.z = 0.;
	}
	// Use emission to render the normal value
	else if (camera_layers == NORMAL_LAYER)
	{
		ALBEDO = vec3(0.0);
		EMISSION = 0.5 * (NORMAL + vec3(1.0));
	}
	// Render albedo (and optionally alpha)
	else
	{
		ALBEDO = color.rgb;
#ifndef OPAQUE
		ALPHA = color.a;
#endif
		// Since the fragment() function has to be overridden, you may also want to look up how to
		// render out other common properties, like roughness, emission, metallic, etc...
	}
}

// Called once for every pixel-light pair.
//void light()
//{
	//// Make sure it is unshaded for depth and normals
	//if (camera_layers == DEPTH_LAYER || camera_layers == NORMAL_LAYER)
	//{
		//DIFFUSE_LIGHT = vec3(0.0);
		//SPECULAR_LIGHT = vec3(0.0);
	//}
	//// Display regular light properties
	//else
	//{
		//// Calculate diffuse using Lambert model (taken from the Godot docs with a slight change)
		//DIFFUSE_LIGHT += clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION * LIGHT_COLOR / PI;
		//// Since the light() function has to be overridden, you may also want to look up how to
		//// calculate specular light...
	//}
//}
