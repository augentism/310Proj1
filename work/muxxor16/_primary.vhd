library verilog;
use verilog.vl_types.all;
entity muxxor16 is
    port(
        y               : out    vl_logic_vector(15 downto 0);
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0)
    );
end muxxor16;
