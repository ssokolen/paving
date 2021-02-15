if (settings.outformat == "") settings.outformat="pdf"; 

import patterns;

//////////////////////////////////////////////////////////////////////////
// Patterns

// Stacking
void stack(picture pic, guide g, real n, pair offset = (0, 0), pen p) {
  
  for (int i = 0; i < n; ++i) {
    draw(pic, shift(offset*i)*g, p);
  }

}

// Running bond
picture running_bond(real W = 5mm, pen p = currentpen) {
  picture tiling;

  guide hbrick = box((0,0), (W, W/2));

  stack(tiling, shift(-W/2, 0)*hbrick, 2, (W, 0), p);
  draw(tiling, shift(0, W/2)*hbrick, p);
  
  clip(tiling, box((0, 0), (W, W)) );
  return tiling;
}

// Stack bond
picture stack_bond(real W = 5mm, pen p = currentpen) {
  picture tiling;

  guide hbrick = box((0,0), (W, W/2));

  draw(tiling, hbrick, p);
  draw(tiling, shift(0, W/2)*hbrick, p);
  
  clip(tiling, box((0, 0), (W, W)) );
  return tiling;
}

// Herringbone
picture herringbone(real W = 5mm, pen p = currentpen) {
  picture tiling;

  guide hbrick = box((0,0), (W, W/2));
  guide vbrick = shift(W/2, 0)*rotate(90)*hbrick;

  stack(tiling, hbrick, 4, (W/2, W/2), p);
  stack(tiling, shift(0, W/2)*vbrick, 3, (W/2, W/2), p);
  stack(tiling, shift(W, -W/2)*vbrick, 2, (W/2, W/2), p);

  draw(tiling, shift(-W/2, W*3/2)*hbrick);
  
  clip(tiling, box((0, 0), (W*2, W*2)) );
  return tiling;
}

// Basket weave
picture basket_weave(real W = 5mm, pen p = currentpen) {
  picture tiling;

  guide hbrick = box((0,0), (W, W/2));
  guide vbrick = shift(W/2, 0)*rotate(90)*hbrick;

  stack(tiling, hbrick, 2, (0, W/2), p);
  stack(tiling, shift(W, 0)*vbrick, 2, (W/2, 0), p);
  stack(tiling, shift(0, W)*vbrick, 2, (W/2, 0), p);
  stack(tiling, shift(W, W)*hbrick, 2, (0, W/2), p);

  clip(tiling, box((0, 0), (W*2, W*2)) );
  return tiling;
}

// Basket weave and stack bond
picture basket_weave_stack_bond(real W = 5mm, pen p = currentpen) {
  picture tiling;

  guide hbrick = box((0,0), (W, W/2));
  guide vbrick = shift(W/2, 0)*rotate(90)*hbrick;

  stack(tiling, vbrick, 2, (W/2, 0), p);
  draw(tiling, shift(0,W)*hbrick, p);

  clip(tiling, box((0, 0), (W*2, W*2)) );
  return tiling;
}

// Basket weave variation
picture basket_weave_variation(real W = 5mm, pen p = currentpen) {
  picture tiling;

  guide hbrick = box((0,0), (W, W/2));
  guide vbrick = shift(W/2, 0)*rotate(90)*hbrick;

  draw(tiling, hbrick, p);
  stack(tiling, shift(W, 0)*vbrick, 2, (W/2, 0), p);
  stack(tiling, shift(0, W/2)*vbrick, 2, (W/2, 0), p);
  draw(tiling, shift(W, W)*hbrick, p);

  clip(tiling, box((0, 0), (W*2, W*2)) );
  return tiling;
}

// Flagstone
picture flagstone(real W = 5mm, pen p = currentpen, bool expand = true) {
  picture tiling;

  guide small = box((0,0), (W, W));
  guide wide = box((0,0), (W*2, W));
  guide tall = shift(W, 0)*rotate(90)*wide;
  guide big = box((0,0), (W*2, W*2));

  // Row 1
  draw(tiling, big, p);
  draw(tiling, shift(W*2, 0)*big, p);
  draw(tiling, shift(W*4, 0)*wide, p);
  draw(tiling, shift(W*4, W)*small, p);
  draw(tiling, shift(W*5, W)*small, p);

  // Row 2
  draw(tiling, shift(0, W*2)*tall, p);
  draw(tiling, shift(W, W*2)*small, p);
  draw(tiling, shift(W*2, W*2)*wide, p);
  draw(tiling, shift(W*3, W*3)*small, p);
  draw(tiling, shift(W*4, W*2)*big, p);

  // Row 3
  draw(tiling, shift(0, W*4)*small, p);
  draw(tiling, shift(0, W*5)*wide, p);
  draw(tiling, shift(W*2, W*5)*small, p);
  draw(tiling, shift(W*3, W*4)*big, p);
  draw(tiling, shift(W*5, W*4)*tall, p);

  // Off-grid block
  draw(tiling, shift(W, W*3)*big, p);
  clip(tiling, box((0, 0), (W*6, W*6)) );

  if ( expand ) {

    add(tiling, shift(W*6, 0)*rotate(90, (W*3, W*3))*tiling);
    clip(tiling, box((0, 0), (W*12, W*6)));

  }

  return tiling;
}

//////////////////////////////////////////////////////////////////////////
// Pages

picture generate_pattern(string pattern_string, real width, pen p) {

  picture pattern;

  if ( pattern_string == "running_bond" ) {
    pattern = running_bond(width, p);
  } else if ( pattern_string == "stack_bond" ) {
    pattern = stack_bond(width, p);
  } else if ( pattern_string == "herringbone" ) {
    pattern = herringbone(width, p);
  } else if ( pattern_string == "basket_weave" ) {
    pattern = basket_weave(width, p);
  } else if ( pattern_string == "basket_weave_stack_bond" ) {
    pattern = basket_weave_stack_bond(width, p); 
  } else if ( pattern_string == "basket_weave_variation" ) {
    pattern = basket_weave_variation(width, p);
  } else if ( pattern_string == "flagstone" ) {
    pattern = flagstone(width); 
  } else {
    abort("Pattern not found: " + pattern_string);
  }

  //add(pattern_string, pattern);
  return pattern;
}

// Architects page
picture architects_page(
  string pattern_string, 
  real scale, 
  string scale_string = "", 
  real pattern_width = 8,
  real border_width = 8,
  real margin_width = 1, 
  bool shipout = true,
  pen p = currentpen
) {

  picture page;
  unitsize(page, 1inch);

  real page_width = 8.5;
  real page_height = 11;

  filldraw(page, box( (0, 0), (page_width, page_height) ), white);

  // Default string to basic conversion from scale
  if ( scale_string == "" ) { scale_string = string(scale); }

  // Incorporating scale
  real pattern_width = pattern_width/12*scale;
  real border_width = border_width/12*scale;

  real width = page_width - margin_width*2;
  real height = (page_height - margin_width*3)/2;

  pair position1 = (page_width/2, page_height/3 - margin_width*2/3);
  pair position2 = (page_width/2, page_height*2/3 + margin_width*2/3);

  // Force width and height to a multiple of the border width
  if ( border_width > 0 ) {
    width = ceil(width/border_width)*border_width;
    height = ceil(height/border_width)*border_width;
  }

  picture background;

  picture pattern = generate_pattern(pattern_string, pattern_width, p);
  pair pattern_size = size(pattern, user = false);

  real x = pattern_size.x;
  real y = pattern_size.y;

  // Background is extended in all directions to allow for rotation
  for (int i; i < width/x*1.2; ++i) {
    for (int j; j < height/y*1.2; ++ j) {
      add(background, shift(x*i, y*j)*pattern);
      add(background, shift(-x*i-x, y*j)*pattern);
      add(background, shift(x*i, -y*j-y)*pattern);
    }
  }

  // For the regular frame, clip before moving to keep edge
  path border = box( (0, 0), (width, height) );
  
  picture regular;
  add(regular, background);
  draw(regular, border, p);
  clip(regular, border);
  regular = reflect((-1,0), (1,0))*shift(-width/2, -height/2)*regular;

  // For the rotated frame, just add a rotation
  picture rotated;
  real offset = pattern_width*Sin(45);
  add(rotated, shift(offset, -offset)*rotate(45)*background);
  draw(rotated, border, p);
  clip(rotated, border);
  rotated = reflect((-1,0), (1,0))*shift(-width/2, -height/2)*rotated;

  // Drawing border
  if ( border_width > 0 ) {
    picture row;
    guide border = box( (0, 0), (width + border_width*2, border_width) );
    draw(row, border, p);
    for (int i = 1; i < width/border_width*2 + 4; ++i) {
      draw(row, (i*border_width/2, 0) -- (i*border_width/2, border_width), p);
    }
    clip(row, border);

    picture column;
    add(column, rotate(90)*row);
    clip(column, box( (-border_width, 0), (0, height + border_width*2) ));

    picture border;
    add(border, shift(-width/2-border_width, height/2)*row);
    add(border, shift(-width/2-border_width, -height/2-border_width)*row);
    add(border, shift(-width/2, -height/2-border_width)*column);
    add(border, shift(width/2+border_width, -height/2-border_width)*column);

    add(page, shift(position1)*border);
    add(page, shift(position2)*border);
  }

  add(page, shift(position1)*rotated);
  add(page, shift(position2)*regular);

  picture scale_label;
  label(scale_label, Label(scale_string + "'' = 1'-0''"));
  add(page, shift(page_width/2, page_height/2)*scale_label);

  string file = pattern_string + "_" + replace(string(scale), ".", "_");

  if ( shipout ) {
    shipout(file, page); 
  }

  return page;
}

// Multiple architects page
picture[] architects_pages(
  string[] pattern_string, 
  real[] scale, 
  string[] scale_string, 
  real pattern_width = 8,
  real border_width = 8,
  real margin_width = 1, 
  bool shipout = true,
  pen p = currentpen
) {

  picture[] pages;

  for (int i = 0; i < pattern_string.length; ++i) {
    for (int j = 0; j < scale.length; ++j ) {
      picture page = architects_page(
        pattern_string[i], scale[j], scale_string[j], 
        pattern_width, border_width, margin_width, true, p
      );

      pages.push(page);
    }
  }

  return pages;
}

//////////////////////////////////////////////////////////////////////////
// Some example code

/*
string[] brick_patterns = {
  "running_bond", "stack_bond", "herringbone",
  "basket_weave", "basket_weave_stack_bond", "basket_weave_variation"
};

string[] flagstone_patterns = {
  "flagstone"
};

real[] scales = {1/4, 3/8};
string[] scale_strings = {"1/4", "3/8"};

architects_pages(brick_patterns, scales, scale_strings, 8);
architects_pages(flagstone_patterns, scales, scale_strings, 12);

architects_page("herringbone", 1/4, "1/4", 8);
*/
