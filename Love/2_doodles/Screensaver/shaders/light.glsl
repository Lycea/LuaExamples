//uniform vec2 mouse;
vec4 pix;

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    float r = 20.0;
    pix = vec4(0,0,0,1);
    float t = distance(screen_coords,vec2(100,100));
    if (t< r)
    {
      pix = vec4(1,0,0,1);
    }
	 
	 return pix;

}