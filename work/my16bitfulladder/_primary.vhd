library verilog;
use verilog.vl_types.all;
entity my16bitfulladder is
    port(
        S               : out    vl_logic_vector(15 downto 0);
        Cout            : out    vl_logic;
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        Cin             : in     vl_logic
    );
end my16bitfulladder;
