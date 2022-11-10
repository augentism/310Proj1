library verilog;
use verilog.vl_types.all;
entity my1bitfulladder is
    port(
        Cout            : out    vl_logic;
        S               : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        Cin             : in     vl_logic
    );
end my1bitfulladder;
