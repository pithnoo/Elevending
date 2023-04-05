shader_type canvas_item;

uniform bool active = false;
uniform vec4 colour: hint_color = vec4(1.0);

void fragment(){
	vec4 previous_colour = texture(TEXTURE, UV);
	vec4 white_colour = vec4(colour.r,colour.g,colour.b,previous_colour.a);
	
	vec4 new_colour = previous_colour;
	
	if(active == true){
		new_colour = white_colour
	}
	COLOR = new_colour;
}