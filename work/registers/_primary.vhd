library verilog;
use verilog.vl_types.all;
entity registers is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PC_reg          : out    vl_logic_vector(7 downto 0);
        PC_next         : in     vl_logic_vector(7 downto 0);
        IR_reg          : out    vl_logic_vector(15 downto 0);
        IR_next         : in     vl_logic_vector(15 downto 0);
        ACC_reg         : out    vl_logic_vector(15 downto 0);
        ACC_next        : in     vl_logic_vector(15 downto 0);
        MDR_reg         : out    vl_logic_vector(15 downto 0);
        MDR_next        : in     vl_logic_vector(15 downto 0);
        MAR_reg         : out    vl_logic_vector(7 downto 0);
        MAR_next        : in     vl_logic_vector(7 downto 0);
        Zflag_reg       : out    vl_logic;
        zflag_next      : in     vl_logic
    );
end registers;
