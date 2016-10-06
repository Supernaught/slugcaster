vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
  if(screen_coords.x > 400){
    return vec4(1.0,0.0,0.0,1.0);//red
  }
  else
  {
    return vec4(0.0,0.0,1.0,1.0);//blue
  }
}
