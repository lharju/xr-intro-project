shader_type spatial;

uniform sampler2D normal_tex : hint_normal;
uniform sampler2D screen_tex : hint_screen_texture;



void fragment() {
	vec2 color = NORMAL.rg;
	ALBEDO = vec3(color, 0.0);
	ALBEDO = texture(screen_tex, SCREEN_UV -  color * 0.6).rgb;
}


