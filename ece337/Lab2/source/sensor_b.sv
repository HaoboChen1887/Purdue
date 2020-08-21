// $Id: $
// File name:   sensor_b.sv
// Created:     1/18/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Behavioral style sensor error detector design

module sensor_b(
	input wire [3:0] sensors,
	output reg error
);

	always @ (sensors) begin
		error=(sensors[1] & sensors[3] | sensors[1] & sensors[2] | sensors[0]);		
	end
endmodule
