library verilog;
use verilog.vl_types.all;
entity proj1 is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MemRW_IO        : out    vl_logic;
        MemAddr_IO      : out    vl_logic_vector(7 downto 0);
        MemD_IO         : out    vl_logic_vector(15 downto 0)
    );
end proj1;
