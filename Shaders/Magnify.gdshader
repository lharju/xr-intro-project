shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D screen_tex : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = ((SCREEN_UV * 2.0 - 1.0) * 0.1) * 0.5 - 0.5;
	ALBEDO = texture(screen_tex, UV *0.9).rgb* 0.8;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
