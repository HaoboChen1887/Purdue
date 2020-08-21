`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  import cpu_types_pkg::*;

  logic ihit, dhit;
  logic imemREN, dmemREN, dmemWEN, dWEN, dREN;
  logic halt, cuhalt, PCEN;

  modport ruif(
    input ihit, dhit,
    input dWEN, dREN,
    input cuhalt,
    output halt, imemREN, dmemREN, dmemWEN, PCEN
  );
endinterface
`endif
