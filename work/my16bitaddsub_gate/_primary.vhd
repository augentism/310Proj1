library verilog;
use verilog.vl_types.all;
entity my16bitaddsub_gate is
    port(
        O               : out    vl_logic_vector(15 downto 0);
        Cout            : out    vl_logic;
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        S               : in     vl_logic
    );
end my16bitaddsub_gate;
