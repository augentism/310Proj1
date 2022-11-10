library verilog;
use verilog.vl_types.all;
entity ctr is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        zflag           : in     vl_logic;
        opcode          : in     vl_logic_vector(7 downto 0);
        muxPC           : out    vl_logic;
        muxMAR          : out    vl_logic;
        muxACC          : out    vl_logic;
        loadMAR         : out    vl_logic;
        loadPC          : out    vl_logic;
        loadACC         : out    vl_logic;
        loadMDR         : out    vl_logic;
        loadIR          : out    vl_logic;
        opALU           : out    vl_logic_vector(1 downto 0);
        MemRW           : out    vl_logic;
        ACC_reg         : in     vl_logic_vector(15 downto 0);
        MDR_reg         : in     vl_logic_vector(15 downto 0);
        div_out         : out    vl_logic_vector(15 downto 0);
        isDivide        : out    vl_logic
    );
end ctr;
