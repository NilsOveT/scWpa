library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.b7seg.all;

entity scWpa is
	port(
	
	clock_50 : in std_logic;
	
	--hex0 : out std_logic_vector (6 downto 0);
	--hex1 : out std_logic_vector (6 downto 0);
	--hex2 : out std_logic_vector (6 downto 0);
	--hex3 : out std_logic_vector (6 downto 0);
	--hex4 : out std_logic_vector (6 downto 0);
	--hex5 : out std_logic_vector (6 downto 0);
	
	-----HPS connections-------
	hps_conv_usb_n: inout std_logic;
	hps_ddr3_addr: out std_logic_vector(14 downto 0);
	hps_ddr3_ba: out std_logic_vector(2 downto 0);
	hps_ddr3_cas_n: out std_logic;
	hps_ddr3_cke: out std_logic;
	hps_ddr3_ck_n: out std_logic;
	hps_ddr3_ck_p: out std_logic;
	hps_ddr3_cs_n: out std_logic;
	hps_ddr3_dm: out std_logic_vector(3 downto 0);
	hps_ddr3_dq: inout std_logic_vector(31 downto 0);
	hps_ddr3_dqs_n: inout std_logic_vector(3 downto 0);
	hps_ddr3_dqs_p: inout std_logic_vector(3 downto 0);
	hps_ddr3_odt: out std_logic;
	hps_ddr3_ras_n: out std_logic;
	hps_ddr3_reset_n: out std_logic;
	hps_ddr3_rzq: in std_logic;
	hps_ddr3_we_n: out std_logic;
	hps_enet_gtx_clk: out std_logic;
	hps_enet_int_n: inout std_logic;
	hps_enet_mdc: out std_logic;
	hps_enet_mdio: inout std_logic;
	hps_enet_rx_clk: in std_logic;
	hps_enet_rx_data: in std_logic_vector (3 downto 0);
	hps_enet_rx_dv: in std_logic;
	hps_enet_tx_data: out std_logic_vector(3 downto 0);
	hps_enet_tx_en: out std_logic;
	hps_key: inout std_logic;
	hps_sd_clk: out std_logic;
	hps_sd_cmd: inout std_logic;
	hps_sd_data: inout std_logic_vector(3 downto 0);
	hps_uart_rx: in std_logic;
	hps_uart_tx: out std_logic;
	hps_usb_clkout: in std_logic;
	hps_usb_data: inout std_logic_vector(7 downto 0);
	hps_usb_dir: in std_logic;
	hps_usb_nxt: in std_logic;
	hps_usb_stp: out std_logic);
end scWpa;

architecture main of scWpa is
	
	 component soc_system is
        port (
            clk_clk                                 : in    std_logic                     := 'X';             -- clk
            hps_0_h2f_reset_reset_n                 : out   std_logic;                                        -- reset_n
            hps_io_hps_io_emac1_inst_TX_CLK         : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0           : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1           : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2           : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3           : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO           : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC            : out   std_logic;                                        -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL         : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL         : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK         : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3           : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD             : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK             : out   std_logic;                                        -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3              : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7              : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP             : out   std_logic;                                        -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT             : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
            hps_io_hps_io_uart0_inst_RX             : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX             : out   std_logic;                                        -- hps_io_uart0_inst_TX
            memory_mem_a                            : out   std_logic_vector(14 downto 0);                    -- mem_a
            memory_mem_ba                           : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck                           : out   std_logic;                                        -- mem_ck
            memory_mem_ck_n                         : out   std_logic;                                        -- mem_ck_n
            memory_mem_cke                          : out   std_logic;                                        -- mem_cke
            memory_mem_cs_n                         : out   std_logic;                                        -- mem_cs_n
            memory_mem_ras_n                        : out   std_logic;                                        -- mem_ras_n
            memory_mem_cas_n                        : out   std_logic;                                        -- mem_cas_n
            memory_mem_we_n                         : out   std_logic;                                        -- mem_we_n
            memory_mem_reset_n                      : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq                           : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
            memory_mem_dqs                          : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
            memory_mem_dqs_n                        : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_mem_odt                          : out   std_logic;                                        -- mem_odt
            memory_mem_dm                           : out   std_logic_vector(3 downto 0);                     -- mem_dm
            memory_oct_rzqin                        : in    std_logic                     := 'X';             -- oct_rzqin
            reset_reset_n                           : in    std_logic                     := 'X';             -- reset_n
            sndhps_external_connection_export : out   std_logic_vector(4 downto 0);                     -- export
            result_external_connection_export       : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            sndfpga_external_connection_export  : in    std_logic_vector(4 downto 0)  := (others => '1'); -- export
            datahps_external_connection_export        : out   std_logic_vector(31 downto 0)                    -- export
            );
    end component soc_system;
	
	signal hps_h2f_rst: std_logic;
	
	signal padCheck: boolean := false;
	signal ssidCheck: boolean := false;
	
	subtype word_type is unsigned(31 downto 0);
	
	type wordArray is array(79 downto 0) of word_type;
	type outData is array(7 downto 0) of word_type;
	type shaCtx is array(4 downto 0) of word_type;
	type inData is array(19 downto 0) of word_type;
	
	
	signal wordSignal_0 : wordArray := (others=> (others => '0'));
	signal wordSignal_1 : wordArray := (others=> (others => '0'));
	signal newData: inData := (others=> (others => '0'));
	signal sendData: outData := (others=> (others => '0'));
	
	signal pmkCtx_0: shaCtx := (others=> (others => '0'));
	signal tempCtx_0: shaCtx := (others=> (others => '0'));
	signal pmkCtx_1: shaCtx := (others=> (others => '0'));
	signal tempCtx_1: shaCtx := (others=> (others => '0'));
	signal ipad: shaCtx := (others=> (others => '0'));
	signal opad: shaCtx := (others=> (others => '0'));
	signal pad: shaCtx := (others=> (others => '0'));
	
	type state_type is (start, newHash, prep, mainLoop, collectHash, newIteration, newTmp, checkCount, send, testState);
	signal state : state_type := start;
		
	signal dataFromHps: std_logic_vector (31 downto 0):= (others => '0');	
	signal dataFromFpga: std_logic_vector (31 downto 0) := (others => '0');
	
	signal A: outData := (others=> (others => '0'));	
	signal B: outData := (others=> (others => '0'));	
	signal C: outData := (others=> (others => '0'));	
	signal D: outData := (others=> (others => '0'));	
	signal E: outData := (others=> (others => '0'));	
	
	
	signal fpgaCount: std_logic_vector (4 downto 0):= (others => '0');
	signal hpsCount: std_logic_vector (4 downto 0):= (others => '0');
	
	signal sndCount: integer range 0 to 20 := 0;
	
	signal iterationCount: integer range 0 to 4096 := 0;
begin
	
	u0 : component soc_system
        port map (
            clk_clk                               => clock_50,                               --                        clk.clk
            hps_0_h2f_reset_reset_n               => hps_h2f_rst,               --            hps_0_h2f_reset.reset_n
            hps_io_hps_io_emac1_inst_TX_CLK => hps_enet_gtx_clk, --               hps_0_hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0   => hps_enet_tx_data(0),   --                           .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1   => hps_enet_tx_data(1),   --                           .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2   => hps_enet_tx_data(2),   --                           .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3   => hps_enet_tx_data(3),   --                           .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0   => hps_enet_rx_data(0),   --                           .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO   => hps_enet_mdio,   --                           .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC    => hps_enet_mdc,    --                           .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => hps_enet_rx_dv, --                           .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => hps_enet_tx_en, --                           .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => hps_enet_rx_clk, --                           .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1   => hps_enet_rx_data(1),   --                           .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2   => hps_enet_rx_data(2),   --                           .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3   => hps_enet_rx_data(3),   --                           .hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD     => hps_sd_cmd,     --                           .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0      => hps_sd_data(0),      --                           .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1      => hps_sd_data(1),      --                           .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK     => hps_sd_clk,     --                           .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2      => hps_sd_data(2),      --                           .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3      => hps_sd_data(3),      --                           .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0      => hps_usb_data(0),      --                           .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1      => hps_usb_data(1),      --                           .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2      => hps_usb_data(2),      --                           .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3      => hps_usb_data(3),      --                           .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4      => hps_usb_data(4),      --                           .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5      => hps_usb_data(5),      --                           .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6      => hps_usb_data(6),      --                           .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7      => hps_usb_data(7),      --                           .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK     => hps_usb_clkout,     --                           .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP     => hps_usb_stp,     --                           .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR     => hps_usb_dir,     --                           .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT     => hps_usb_nxt,     --                           .hps_io_usb1_inst_NXT
            hps_io_hps_io_uart0_inst_RX     => hps_uart_rx,     --                           .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX     => hps_uart_tx,     --                           .hps_io_uart0_inst_TX
            memory_mem_a                          => hps_ddr3_addr,                          --                     memory.mem_a
            memory_mem_ba                         => hps_ddr3_ba,                         --                           .mem_ba
            memory_mem_ck                         => hps_ddr3_ck_p,                         --                           .mem_ck
            memory_mem_ck_n                       => hps_ddr3_ck_n,                       --                           .mem_ck_n
            memory_mem_cke                        => hps_ddr3_cke,                        --                           .mem_cke
            memory_mem_cs_n                       => hps_ddr3_cs_n,                       --                           .mem_cs_n
            memory_mem_ras_n                      => hps_ddr3_ras_n,                      --                           .mem_ras_n
            memory_mem_cas_n                      => hps_ddr3_cas_n,                      --                           .mem_cas_n
            memory_mem_we_n                       => hps_ddr3_we_n,                       --                           .mem_we_n
            memory_mem_reset_n                    => hps_ddr3_reset_n,                    --                           .mem_reset_n
            memory_mem_dq                         => hps_ddr3_dq,                         --                           .mem_dq
            memory_mem_dqs                        => hps_ddr3_dqs_p,                        --                           .mem_dqs
            memory_mem_dqs_n                      => hps_ddr3_dqs_n,                      --                           .mem_dqs_n
            memory_mem_odt                        => hps_ddr3_odt,                        --                           .mem_odt
            memory_mem_dm                         => hps_ddr3_dm,                         --                           .mem_dm
            memory_oct_rzqin                      => hps_ddr3_rzq,                      --                           .oct_rzqin
            reset_reset_n                         => '1',                         --                      reset.reset_n
            dataHps_external_connection_export        => dataFromHps,        --        hash0_external_connection.export
            sndfpga_external_connection_export  => fpgaCount,  --  snddincount_external_connection.export
            result_external_connection_export     => dataFromFpga,      -- result_external_connection.export
			sndhps_external_connection_export => hpsCount  -- snddoutcount_external_connection.export
        );
	
	process(clock_50)
	
		variable countWords: integer range 16 to 80 := 16;
		variable mainCount: integer range 0 to 80 := 0;
	begin
		if(rising_edge(clock_50))then
			case state is
				when start =>
					iterationCount <= 0;
					sndCount <= 0;
					
					padCheck <= false;
					ssidCheck <= false;
					
					wordSignal_0 <= (others=> (others => '0'));
					wordSignal_1 <= (others=> (others => '0'));
					newData <= (others=> (others => '0'));
					sendData <= (others=> (others => '0'));
					pmkCtx_0 <= (others=> (others => '0'));
					tempCtx_0 <= (others=> (others => '0'));
					pmkCtx_1 <= (others=> (others => '0'));
					tempCtx_1 <= (others=> (others => '0'));
					ipad <= (others=> (others => '0'));
					opad <= (others=> (others => '0'));
					pad <= (others=> (others => '0'));
					
					if unsigned(hpsCount) = to_unsigned(22, 5) then
						fpgaCount <= hpsCount;
						state <= newHash;
					end if;
----------------------------------------------------------------------------------------
				when newHash =>
					if fpgaCount = hpsCount then
						null;
					elsif unsigned(hpsCount) < 20 then
						newData(sndCount) <= unsigned(dataFromHps);
						sndCount <= sndCount + 1;
						fpgaCount <= hpsCount;
					elsif unsigned(hpsCount) = to_unsigned(20, 5) then
						tempCtx_1(4) <= newData(19);
						tempCtx_1(3) <= newData(18);
						tempCtx_1(2) <= newData(17);
						tempCtx_1(1) <= newData(16);
						tempCtx_1(0) <= newData(15);
						
						tempCtx_0(4) <= newData(14);
						tempCtx_0(3) <= newData(13);
						tempCtx_0(2) <= newData(12);
						tempCtx_0(1) <= newData(11);
						tempCtx_0(0) <= newData(10);
						
						opad(4) <= newData(9);
						opad(3) <= newData(8);
						opad(2) <= newData(7);
						opad(1) <= newData(6);
						opad(0) <= newData(5);
						
						ipad(4) <= newData(4);
						ipad(3) <= newData(3);
						ipad(2) <= newData(2);
						ipad(1) <= newData(1);
						ipad(0) <= newData(0);
						fpgaCount <= hpsCount;
						sndCount <= 0;
						elsif unsigned(hpsCount) = to_unsigned(21, 5) then
							fpgaCount <= hpsCount;
							pad <= ipad;
							pmkCtx_0 <= tempCtx_0;
							pmkCtx_1 <= tempCtx_1;
							state <= prep;
					end if;
--------------------------------------------------------------------------------
				when prep =>
					mainCount := 0;
					countWords := 16;
					
					A(0) <= pad(0);
					B(0) <= pad(1);
					C(0) <= pad(2);
					D(0) <= pad(3);
					E(0) <= pad(4);
					A(1) <= pad(0);
					B(1) <= pad(1);
					C(1) <= pad(2);
					D(1) <= pad(3);
					E(1) <= pad(4);
					
					wordSignal_0(0) <= tempCtx_0(0);
					wordSignal_0(1) <= tempCtx_0(1);
					wordSignal_0(2) <= tempCtx_0(2);
					wordSignal_0(3) <= tempCtx_0(3);
					wordSignal_0(4) <= tempCtx_0(4);
					wordSignal_1(0) <= tempCtx_1(0);
					wordSignal_1(1) <= tempCtx_1(1);
					wordSignal_1(2) <= tempCtx_1(2);
					wordSignal_1(3) <= tempCtx_1(3);
					wordSignal_1(4) <= tempCtx_1(4);
					
					wordSignal_0(5) <= x"80000000";
					wordSignal_0(15) <= to_unsigned(672 , 32);
					wordSignal_1(5) <= x"80000000";
					wordSignal_1(15) <= to_unsigned(672 , 32);
					state <= mainLoop;
------------------------------------------------------------------------------
				when mainLoop =>
				
					if(countWords<80)then
						wordSignal_0(countWords) <= (wordSignal_0(countWords-3) xor wordSignal_0(countWords-8) xor wordSignal_0(countWords-14) xor wordSignal_0(countWords-16)) rol 1;
						wordSignal_1(countWords) <= (wordSignal_1(countWords-3) xor wordSignal_1(countWords-8) xor wordSignal_1(countWords-14) xor wordSignal_1(countWords-16)) rol 1;
						countWords := countWords + 1;
					end if;
				
					if(mainCount <= 19)then
						E(0) <= D(0);
						D(0) <= C(0);
						C(0) <= B(0) rol 30;
						B(0) <= A(0);
						A(0) <= (A(0) rol 5) + ((B(0) and C(0)) or ((not B(0)) and D(0))) + E(0) + x"5A827999" + wordSignal_0(mainCount);
						E(1) <= D(1);
						D(1) <= C(1);
						C(1) <= B(1) rol 30;
						B(1) <= A(1);
						A(1) <= (A(1) rol 5) + ((B(1) and C(1)) or ((not B(1)) and D(1))) + E(1) + x"5A827999" + wordSignal_1(mainCount);
						--F := (B and C) or ((not B) and D);
						--K := x"5A827999";
							
						mainCount := mainCount + 1;
							
					elsif(mainCount <= 39)then
						E(0) <= D(0);
						D(0) <= C(0);
						C(0) <= B(0) rol 30;
						B(0) <= A(0);
						A(0) <= (A(0) rol 5) + (B(0) xor C(0) xor D(0)) + E(0) + x"6ED9EBA1" + wordSignal_0(mainCount);
						E(1) <= D(1);
						D(1) <= C(1);
						C(1) <= B(1) rol 30;
						B(1) <= A(1);
						A(1) <= (A(1) rol 5) + (B(1) xor C(1) xor D(1)) + E(1) + x"6ED9EBA1" + wordSignal_1(mainCount);
						--F := B xor C xor D;
						--K := x"6ED9EBA1";
							
						mainCount := mainCount + 1;
							
					elsif(mainCount <= 59)then
						E(0) <= D(0);
						D(0) <= C(0);
						C(0) <= B(0) rol 30;
						B(0) <= A(0);
						A(0) <= (A(0) rol 5) + ((B(0) and C(0)) or (B(0) and D(0)) or (C(0) and D(0))) + E(0) + x"8F1BBCDC" + wordSignal_0(mainCount);
						E(1) <= D(1);
						D(1) <= C(1);
						C(1) <= B(1) rol 30;
						B(1) <= A(1);
						A(1) <= (A(1) rol 5) + ((B(1) and C(1)) or (B(1) and D(1)) or (C(1) and D(1))) + E(1) + x"8F1BBCDC" + wordSignal_1(mainCount);
						--F := (B and C) or (B and D) or (C and D);
						--K := x"8F1BBCDC";
						
						mainCount := mainCount + 1;
							
					elsif(mainCount <= 79)then
						E(0) <= D(0);
						D(0) <= C(0);
						C(0) <= B(0) rol 30;
						B(0) <= A(0);
						A(0) <= (A(0) rol 5) + (B(0) xor C(0) xor D(0)) + E(0) + x"CA62C1D6" + wordSignal_0(mainCount);
						E(1) <= D(1);
						D(1) <= C(1);
						C(1) <= B(1) rol 30;
						B(1) <= A(1);
						A(1) <= (A(1) rol 5) + (B(1) xor C(1) xor D(1)) + E(1) + x"CA62C1D6" + wordSignal_1(mainCount);
						--F := B xor C xor D;
						--K := x"CA62C1D6";
							
						mainCount := mainCount + 1;
							
					else
						state <= collectHash;
					end if;
---------------------------------------------------------------------------------------
				when collectHash =>
					tempCtx_0(0) <= (A(0) + pad(0));
					tempCtx_0(1) <= (B(0) + pad(1));
					tempCtx_0(2) <= (C(0) + pad(2));
					tempCtx_0(3) <= (D(0) + pad(3));
					tempCtx_0(4) <= (E(0) + pad(4));
					tempCtx_1(0) <= (A(1) + pad(0));
					tempCtx_1(1) <= (B(1) + pad(1));
					tempCtx_1(2) <= (C(1) + pad(2));
					tempCtx_1(3) <= (D(1) + pad(3));
					tempCtx_1(4) <= (E(1) + pad(4));
					state <= newIteration;
					--state <= testState;
-----------------------------------------------------------------------------------
				when newIteration =>
					if padCheck then
						padCheck <= false;
						iterationCount <= iterationCount + 1;
						state <= checkCount;
						pmkCtx_0(0) <= pmkCtx_0(0) xor tempCtx_0(0);
						pmkCtx_0(1) <= pmkCtx_0(1) xor tempCtx_0(1);
						pmkCtx_0(2) <= pmkCtx_0(2) xor tempCtx_0(2);
						pmkCtx_0(3) <= pmkCtx_0(3) xor tempCtx_0(3);
						pmkCtx_0(4) <= pmkCtx_0(4) xor tempCtx_0(4);
						pmkCtx_1(0) <= pmkCtx_1(0) xor tempCtx_1(0);
						pmkCtx_1(1) <= pmkCtx_1(1) xor tempCtx_1(1);
						pmkCtx_1(2) <= pmkCtx_1(2) xor tempCtx_1(2);
						pmkCtx_1(3) <= pmkCtx_1(3) xor tempCtx_1(3);
						pmkCtx_1(4) <= pmkCtx_1(4) xor tempCtx_1(4);
					else 
						pad <= opad;
						padCheck <= true;
						state <= prep;
						wordSignal_0 <= (others=> (others => '0'));
						wordSignal_1 <= (others=> (others => '0'));
					end if;
-------------------------------------------------------------------------					
				when checkCount =>
					if iterationCount < 4095 then
						pad <= ipad;
						state <= prep;
						wordSignal_0 <= (others=> (others => '0'));
						wordSignal_1 <= (others=> (others => '0'));
					else
						iterationCount <= 0;
						state <= send;
						sendData(7) <= pmkCtx_1(2);
						sendData(6) <= pmkCtx_1(1);
						sendData(5) <= pmkCtx_1(0);
						sendData(4) <= pmkCtx_0(4);
						sendData(3) <= pmkCtx_0(3);
						sendData(2) <= pmkCtx_0(2);
						sendData(1) <= pmkCtx_0(1);
						sendData(0) <= pmkCtx_0(0);
					end if;
-------------------------------------------------------------------------
				when send =>
					if fpgaCount = hpsCount then
						null;
					elsif (unsigned(hpsCount) < to_unsigned(8, 5)) then
						dataFromFpga <= std_logic_vector(sendData(sndCount));
						fpgaCount <= hpsCount;
						sndCount <= sndCount + 1;
					else 
						sndCount <= 0;
						fpgaCount <= hpsCount;
						state <= start;
					end if;
------------------------------------------------------------------------
				when others =>
					state <= start;
			end case;		
		end if;
	end process;
end main;