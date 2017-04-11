uniform float multi[4];

vec4 effect( vec4 col, Image texture, vec2 texturePos, vec2 screenPos )
{
	// get color of pixels:
  
  vec4 pixel = Texel(texture,texturePos);
  
	pixel.r = pixel.r * multi[0];
  pixel.b = pixel.b * multi[1];
  pixel.g = pixel.g * multi[2];
 // col.a = col.a * 0.5;
	// return color for current pixel
	return pixel;
}
