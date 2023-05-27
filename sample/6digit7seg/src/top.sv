module top(
input wire clk,
input wire sw,

output logic [7:0] ROW,
output reg [7:0] COL,
output reg [5:0] onboard_led
);

logic overflow;
reg [5:0] DIGIT;

/*
reg [7:0] ledFrameBuffer [1:0][7:0] = '{
                                      '{8'b00001111,
                                       8'b00001111,
                                       8'b00001111,
                                       8'b00001111,
                                       8'b00001111,
                                       8'b00001111,
                                       8'b00001111,
                                       8'b00001111},
                                      '{8'b11110000,
                                       8'b11110000,
                                       8'b11110000,
                                       8'b11110000,
                                       8'b11110000,
                                       8'b11110000,
                                       8'b11110000,
                                       8'b11110000}};
*/
//parameter FULL_STROKE_STEP = 16'd32768;

timer1 timer_instance(clk, overflow);

//reg [2:0] step;

//reg [2:0] colRed_step;
//reg [7:0] rowBuffer;
//reg [7:0] colRedBuffer;
//reg [7:0] colGreenBuffer;
//reg transitionBit;

always @(posedge overflow)begin
    if(DIGIT == 0)begin
        DIGIT <= 8'b1;
    end else begin
        DIGIT <= DIGIT << 8'b1;
    end
end

assign COL = 8'b11111111;
assign ROW = ~DIGIT;

endmodule

module timer1 #(
  parameter COUNT_MAX = 27000000
) (
  input  wire  clk,
  output logic overflow
);

  logic [$clog2(COUNT_MAX+1)-1:0] counter = 'd0;

  always_ff @ (posedge clk) begin
    if (counter == COUNT_MAX) begin
      counter  <= 'd0;
      overflow <= 'd1;
    end else begin
      counter  <= counter + 'd1;
      overflow <= 'd0;
    end
  end
endmodule

`default_nettype wire