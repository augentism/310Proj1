library verilog;
use verilog.vl_types.all;
entity HW5_1 is
    port(
        s               : out    vl_logic_vector(15 downto 0);
        y               : in     vl_logic_vector(7 downto 0);
        x               : in     vl_logic_vector(7 downto 0)
    );
end HW5_1;
