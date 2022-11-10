library verilog;
use verilog.vl_types.all;
entity my8bitmux is
    port(
        \Out\           : out    vl_logic_vector(7 downto 0);
        A               : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(7 downto 0);
        sel             : in     vl_logic
    );
end my8bitmux;
