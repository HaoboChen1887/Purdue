// $Id: $
// File name:   sensor_s.sv
// Created:     1/18/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Sensor error detector design


module sensor_s (
	input wire [3:0] sensors,
	output wire error
);

	reg tempA1 = 1'b0;
	reg tempA2 = 1'b0;
	reg tempO1 = 1'b0;

	AND2X1 A1 (.Y(tempA1), .A(sensors[3]), .B(sensors[1])); // W * X
	AND2X1 A2 (.Y(tempA2), .A(sensors[2]), .B(sensors[1])); // X * Y
	OR2X1  O1 (.Y(tempO1), .A(sensors[0]), .B(tempA1)); // 
	OR2X1  O2 (.Y(error), .A(tempO1), .B(tempA2));
endmodule
