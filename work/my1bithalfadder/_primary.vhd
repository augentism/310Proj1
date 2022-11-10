library verilog;
use verilog.vl_types.all;
entity my1bithalfadder is
    port(
        sum             : out    vl_logic;
        carry           : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic
    );
end my1bithalfadder;
