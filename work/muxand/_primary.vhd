library verilog;
use verilog.vl_types.all;
entity muxand is
    port(
        y               : out    vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic
    );
end muxand;
