library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        opALU           : in     vl_logic_vector(1 downto 0);
        Rout            : out    vl_logic_vector(15 downto 0)
    );
end alu;
