// System Verilog package file for all the graphics functions needed for this project
package graphics_package;
  // Declare different functions below
  function automatic integer vertical_lines(integer pos_x);
    begin
      if (pos_x >= 0 && pos_x <= 79) begin
          vertical_lines = 0;
      end
      else if (pos_x >= 80 && pos_x <= 159) begin
          vertical_lines = 1;
      end
      else if (pos_x >= 160 && pos_x <= 239) begin
          vertical_lines = 2;
      end
      else if (pos_x >= 240 && pos_x <= 319) begin
          vertical_lines = 3;
      end
      else if (pos_x >= 320 && pos_x <= 399) begin
          vertical_lines = 4;
      end
      else if (pos_x >= 400 && pos_x <= 479) begin
          vertical_lines = 5;
      end
      else if (pos_x >= 480 && pos_x <= 559) begin
          vertical_lines = 6;
      end
      else if (pos_x >= 560 && pos_x <= 639) begin
          vertical_lines = 7;
      end
      else begin
          vertical_lines = 0;
      end
    end
  endfunction


  function automatic integer horizontal_lines(integer pos_y);
    begin
      if (pos_y >= 0 && pos_y <= 79) begin
          horizontal_lines = 0;
      end
      else if (pos_y >= 80 && pos_y <= 159) begin
          horizontal_lines = 1;
      end
      else if (pos_y >= 160 && pos_y <= 239) begin
          horizontal_lines = 2;
      end
      else if (pos_y >= 240 && pos_y <= 319) begin
          horizontal_lines = 3;
      end
      else if (pos_y >= 320 && pos_y <= 399) begin
          horizontal_lines = 4;
      end
      else if (pos_y >= 400 && pos_y <= 479) begin
          horizontal_lines = 5;
      end
      else begin
          horizontal_lines = 0;
      end
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
      if ((pos_x == pos_x_pix) && (pos_y == pos_y_pix))
        rgb = color_pix;
      else
        rgb = color_back;
    end
  endfunction

  function logic [23:0] square(
                        integer pos_x, 
                        integer pos_y,
                        integer pos_x_square,
                        integer pos_y_square,
                        integer dimension,
                        logic [23:0] color_square,
                        logic [23:0] color_back);
    logic [23:0] rgb; // Declaration of the rgb variable

    if (((pos_x >= pos_x_square) && (pos_x <= pos_x_square + dimension)) &&
        ((pos_y >= pos_y_square) && (pos_y <= pos_y_square + dimension))) begin
        rgb = color_square;
    end
    else begin
        rgb = color_back;
    end

    return rgb; // Return the rgb value
  endfunction


  function logic [23:0] rectangle(
                        integer pos_x, 
                        integer pos_y,
                        integer pos_x_rectangle,
                        integer pos_y_rectangle,
                        integer length,
                        logic [23:0] color_rectangle,
                        logic [23:0] color_back);
  begin
      logic [23:0] rgb; // Declare rgb variable
      if ((pos_x >= pos_x_rectangle) && (pos_x <= pos_x_rectangle + length) &&
          (pos_y >= pos_y_rectangle) && (pos_y <= pos_y_rectangle + length)) begin
          rgb = color_rectangle;
      end
      else begin
          rgb = color_back;
      end
      return rgb; // Return rgb value
  end
endfunction



endpackage