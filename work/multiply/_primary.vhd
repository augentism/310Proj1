library verilog;
use verilog.vl_types.all;
entity multiply is
    port(
        s               : out    vl_logic_vector(15 downto 0);
        y               : in     vl_logic_vector(7 downto 0);
        x               : in     vl_logic_vector(7 downto 0)
    );
end multiply;
