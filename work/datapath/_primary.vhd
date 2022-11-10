library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        muxPC           : in     vl_logic;
        muxMAR          : in     vl_logic;
        muxACC          : in     vl_logic;
        loadMAR         : in     vl_logic;
        loadPC          : in     vl_logic;
        loadACC         : in     vl_logic;
        loadMDR         : in     vl_logic;
        loadIR          : in     vl_logic;
        opALU           : in     vl_logic_vector(1 downto 0);
        zflag           : out    vl_logic;
        opcode          : out    vl_logic_vector(7 downto 0);
        MemAddr         : out    vl_logic_vector(7 downto 0);
        MemD            : out    vl_logic_vector(15 downto 0);
        MemQ            : in     vl_logic_vector(15 downto 0);
        div_out         : in     vl_logic_vector(15 downto 0);
        isDivide        : in     vl_logic;
        ACC_reg         : out    vl_logic_vector(15 downto 0);
        MDR_reg         : out    vl_logic_vector(15 downto 0)
    );
end datapath;
