module top(
input wire clk,
input wire sw,

output logic [7:0] ROW,
output reg [7:0] COL,
output logic [7:0] ROW2,
output logic [7:0] COL2,

output reg [5:0] onboard_led
);

logic overflow;
reg [5:0] DIGIT;
reg [7:0] reg_numbers [5:0]={8'b0000110,8'b1011011,8'b1001111,8'b1100110,8'b1101101,8'b1111101};

timer1 timer_instance(clk, overflow);
segment_led leds(overflow, 0, 1, reg_numbers, COL, ROW);
assign COL2 = COL;
assign ROW2 = ~ROW;


//assign COL = 8'b11111111;
//assign ROW = ~DIGIT;

endmodule

module timer1 #(
  parameter COUNT_MAX = 27000
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