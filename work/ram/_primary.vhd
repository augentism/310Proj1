library verilog;
use verilog.vl_types.all;
entity ram is
    port(
        we              : in     vl_logic;
        d               : in     vl_logic_vector(15 downto 0);
        q               : out    vl_logic_vector(15 downto 0);
        addr            : in     vl_logic_vector(7 downto 0)
    );
end ram;
