library verilog;
use verilog.vl_types.all;
entity my1bitmux is
    port(
        \out\           : out    vl_logic;
        i0              : in     vl_logic;
        i1              : in     vl_logic;
        sel             : in     vl_logic
    );
end my1bitmux;
