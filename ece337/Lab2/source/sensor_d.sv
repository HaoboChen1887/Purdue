// $Id: $
// File name:   sensor_d.sv
// Created:     1/18/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Dataflow style sensor error detector specifications.

module sensor_d(
	input wire [3:0] sensors,
	output wire error
);
	assign error = (sensors[1] & sensors[3] | sensors[1] & sensors[2] | sensors[0]);

endmodule
