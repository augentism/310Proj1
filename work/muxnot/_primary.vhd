library verilog;
use verilog.vl_types.all;
entity muxnot is
    port(
        y               : out    vl_logic;
        a               : in     vl_logic
    );
end muxnot;
