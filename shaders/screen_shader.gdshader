shader_type spatial;
render_mode unshaded;
/**
 * screen_shader.gdshader
 *
 * A post-processing shader that has been applied to the FullScreenQuad node in the
 * "main_camera.tscn" scene. In the vertex() function, it just ensures that the quad covers the
 * whole screen. Then, in the fragment() function, it reads from the buffers that have been passed
 * to it and does some basic conversion to get the original values. This info can then be used to
 * render a post-processing effect.
 */



// PREPROCESSOR DIRECTIVES

// Contains layer numbers and some common functions
#include "res://shaders/globals.gdshaderinc"

uniform float time;

// UNIFORMS

/** This texture holds color from the second visual layer. */
uniform sampler2D color_buffer : filter_nearest;

/** This texture holds depth info from the third visual layer. */
uniform sampler2D depth_buffer : filter_nearest;


/** This texture holds normal info from the fourth visual layer. */
uniform sampler2D normal_buffer : filter_nearest;

const highp float NOISE_GRANULARITY = .8/255.0;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsv2rgb_smooth( in vec3 c )
{
    vec3 rgb = clamp( abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0 );

	rgb = rgb*rgb*(3.0-2.0*rgb); // cubic smoothing

	return c.z * mix(vec3(1.0), rgb, c.y);
}

highp float random(highp vec2 coords) {
   return fract(sin(dot(coords.xy, vec2(12.9898,78.233))) * 43758.5453 + time);
}

// Called once for each vertex.
void vertex()
{
	// Make sure the full-screen quad covers the entire screen
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

// Called once for each pixel.
void fragment()
{
	// Read the buffers for this pixel (and convert to original values as necessary)
	vec4 color = texture(color_buffer, SCREEN_UV);
	vec3 normal = 2.0 * texture(normal_buffer, SCREEN_UV).xyz - vec3(1.0);

	vec2 depth_xy = texture(depth_buffer, SCREEN_UV).xy;
	float depth = 1. / depth_xy.x * 2.;

	float modified_depth = depth * pow(1. - depth, 0.5);
	float hue = clamp(pow(modified_depth, 2.), 0., 10.);
	float value = clamp(pow(modified_depth, 2.), 0.02, 10.);
	vec3 colour = hsv2rgb_smooth(vec3(hue, 1., value));

	colour += mix(-NOISE_GRANULARITY, NOISE_GRANULARITY, random(SCREEN_UV));


	if (depth_xy.y == 1. && modified_depth > 0.2) {
			ALBEDO=vec3(0.3);
	} else {
		//if (depth > 0.) {
			ALBEDO = colour;
		//} else {
			//ALBEDO = vec3(0.);
		//}
	}
}
