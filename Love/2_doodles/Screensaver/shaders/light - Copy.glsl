uniform vec2 mouse;
vec4 pix;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
     
	   float dist =sqrt( pow(mouse[0] - screen_coords.x,2)+ pow(mouse [1] - screen_coords.y,2));
	   dist = dist;
	  
    pix.r = color.r ;
    pix.g = color.g ;
    pix.b = color.b ;
    pix.a = 1.0 / dist*10;
	 
	 return pix;

}