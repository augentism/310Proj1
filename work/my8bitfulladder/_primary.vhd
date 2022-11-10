library verilog;
use verilog.vl_types.all;
entity my8bitfulladder is
    port(
        S               : out    vl_logic_vector(7 downto 0);
        Cout            : out    vl_logic;
        A               : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(7 downto 0);
        Cin             : in     vl_logic
    );
end my8bitfulladder;
