// System Verilog package file for all the graphics functions needed for this project
package graphics_package;
  // Declare different functions below
  function integer vertical_lines(integer pos_x);
    begin
      case (pos_x) inside
        [0:79]    : index = 0;
        [80:159]  : index = 1;
        [160:239] : index = 2;
        [240:319] : index = 3;
        [320:399] : index = 4;
        [400:479] : index = 5;
        [480:559] : index = 6;
        [560:639] : index = 7;
        default   : index = 0;
      endcase
    end
  endfunction

  function integer horizontal_lines(integer pos_y);
    begin
      case (pos_y) inside
        [0:79]    : index = 0;
        [80:159]  : index = 1;
        [160:239] : index = 2;
        [240:319] : index = 3;
        [320:399] : index = 4;
        [400:479] : index = 5;
        default   : index = 0;
      endcase
    end
  endfunction

  function logic pixel(
                        integer pos_x, 
                        integer pos_y,
                        integer pos_x_pix,
                        integer pos_y_pix,
                        logic [23:0] color_pix,
                        logic [23:0] color_back);
    begin
      if (pos_x == pos_x_pix) && (pos_y == pos_y_pix)
        rgb = color_pix;
      else
        rgb = color_back;
    end
  endfunction

  function logic square(
                        integer pos_x, 
                        integer pos_y,
                        integer pos_x_square,
                        integer pos_y_square,
                        integer dimension,
                        logic [23:0] color_square,
                        logic [23:0] color_back);
    begin
      if (((pos_x >= pos_x_square) && (pos_x <= pos_x_square + dimension))) &&
          (((pos_y >= pos_y_square) && (pos_y <= pos_y_square + dimension)))
        rgb = color_square;
      else
        rgb = color_back;
    end
  endfunction

  function logic rectangle(
                        integer pos_x, 
                        integer pos_y,
                        integer pos_x_rectangle,
                        integer pos_y_rectangle,
                        integer length,
                        logic [23:0] color_rectangle,
                        logic [23:0] color_back);
    begin
      if (((pos_x >= pos_x_rectangle) && (pos_x <= pos_x_rectangle + length))) &&
          (((pos_y >= pos_y_rectangle) && (pos_y <= pos_y_rectangle + length)))
        rgb = color_rectangle;
      else
        rgb = color_back;
    end
  endfunction


endpackage