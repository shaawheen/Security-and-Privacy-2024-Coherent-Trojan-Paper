 
 
 
-------------------------------------------------------------------------------
-- abc_top_vhd_exdes.vhd
-------------------------------------------------------------------------------
--
--
-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--
--
-------------------------------------------------------------------------------
-- Filename:        abc_top_vhd_exdes.vhd
--
-- Description:     This file is the top level wrapper instaniating abc 
--                  and memory.
--
-- VHDL-Standard:   VHDL'93
--
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


Library xpm;
use xpm.vcomponents.all;


LIBRARY UNISIM;
USE UNISIM.VCOMPONENTS.ALL;

--------------------------------------------------------------------------------
-- Entity Declaration
--------------------------------------------------------------------------------
ENTITY axi_bram_ctrl_0_exdes IS
  PORT (
    -- AXI Clock and Reset
    S_AXI_ACLK              : in    std_logic;
    S_AXI_ARESETN           : in    std_logic;

    -- AXI Write Address Channel Signals (AW)
    S_AXI_AWADDR            : in    std_logic_vector(14 DOWNTO 0);
    S_AXI_AWLEN             : in    std_logic_vector(7 downto 0);
    S_AXI_AWSIZE            : in    std_logic_vector(2 downto 0);
    S_AXI_AWBURST           : in    std_logic_vector(1 downto 0);
    S_AXI_AWLOCK            : in    std_logic;
    S_AXI_AWCACHE           : in    std_logic_vector(3 downto 0);
    S_AXI_AWPROT            : in    std_logic_vector(2 downto 0);
    S_AXI_AWVALID           : in    std_logic;
    S_AXI_AWREADY           : out   std_logic;
    
    -- AXI Write Data Channel Signals (W)
    S_AXI_WDATA             : in    std_logic_vector(31 DOWNTO 0); 
    S_AXI_WSTRB             : in    std_logic_vector(3 DOWNTO 0);
    S_AXI_WLAST             : in    std_logic;
    S_AXI_WVALID            : in    std_logic;
    S_AXI_WREADY            : out   std_logic;

    -- AXI Write Data Response Channel Signals (B)
    S_AXI_BRESP             : out   std_logic_vector(1 downto 0);
    S_AXI_BVALID            : out   std_logic;
    S_AXI_BREADY            : in    std_logic;

    -- AXI Read Address Channel Signals (AR)
    S_AXI_ARADDR            : in    std_logic_vector(14 DOWNTO 0);
    S_AXI_ARLEN             : in    std_logic_vector(7 downto 0);
    S_AXI_ARSIZE            : in    std_logic_vector(2 downto 0);
    S_AXI_ARBURST           : in    std_logic_vector(1 downto 0);
    S_AXI_ARLOCK            : in    std_logic;
    S_AXI_ARCACHE           : in    std_logic_vector(3 downto 0);
    S_AXI_ARPROT            : in    std_logic_vector(2 downto 0);
    S_AXI_ARVALID           : in    std_logic;
    S_AXI_ARREADY           : out   std_logic;

    -- AXI Read Data Channel Signals (R)
    S_AXI_RDATA             : out   std_logic_vector(31 DOWNTO 0);
    S_AXI_RRESP             : out   std_logic_vector(1 downto 0);
    S_AXI_RLAST             : out   std_logic;
    S_AXI_RVALID            : out   std_logic;
    
    S_AXI_RREADY            : in    std_logic
	


);
END axi_bram_ctrl_0_exdes;

ARCHITECTURE xilinx OF axi_bram_ctrl_0_exdes IS
 
attribute DowngradeIPIdentifiedWarnings: string;
attribute DowngradeIPIdentifiedWarnings of xilinx : architecture is "yes";
  ---------------------------------------------------------------------------
  -- FUNCTION : log2roundup
  ---------------------------------------------------------------------------
  FUNCTION log2roundup (data_value : integer) RETURN integer IS
    VARIABLE width       : integer := 0;
    VARIABLE cnt         : integer := 1;
    CONSTANT lower_limit : integer := 1;
    CONSTANT upper_limit : integer := 8;
  BEGIN
    IF (data_value <= 1) THEN
      width   := 0;
    ELSE
      WHILE (cnt < data_value) LOOP
        width := width + 1;
        cnt   := cnt *2;
      END LOOP;
    END IF;
    RETURN width;
  END log2roundup;

  ---------------------------------------------------------------------------
  -- Component Declarations
  ---------------------------------------------------------------------------
 
  COMPONENT axi_bram_ctrl_0 IS
 
  PORT (
    -- AXI Clock and Reset
    S_AXI_ACLK              : in    std_logic;
    S_AXI_ARESETN           : in    std_logic;
    -- AXI Write Address Channel Signals (AW)
    S_AXI_AWADDR            : in    std_logic_vector(14 DOWNTO 0);
    S_AXI_AWLEN             : in    std_logic_vector(7 downto 0);
    S_AXI_AWSIZE            : in    std_logic_vector(2 downto 0);
    S_AXI_AWBURST           : in    std_logic_vector(1 downto 0);
    S_AXI_AWLOCK            : in    std_logic;
    S_AXI_AWCACHE           : in    std_logic_vector(3 downto 0);
    S_AXI_AWPROT            : in    std_logic_vector(2 downto 0);
    S_AXI_AWVALID           : in    std_logic;
    S_AXI_AWREADY           : out   std_logic;

    -- AXI Write Data Channel Signals (W)
    S_AXI_WDATA             : in    std_logic_vector(31 DOWNTO 0); 
    S_AXI_WSTRB             : in    std_logic_vector(3 DOWNTO 0);
    S_AXI_WLAST             : in    std_logic;
    S_AXI_WVALID            : in    std_logic;
    S_AXI_WREADY            : out   std_logic;

    -- AXI Write Data Response Channel Signals (B)
    S_AXI_BRESP             : out   std_logic_vector(1 downto 0);
    S_AXI_BVALID            : out   std_logic;
    S_AXI_BREADY            : in    std_logic;

    -- AXI Read Address Channel Signals (AR)
    S_AXI_ARADDR            : in    std_logic_vector(14 DOWNTO 0);
    S_AXI_ARLEN             : in    std_logic_vector(7 downto 0);
    S_AXI_ARSIZE            : in    std_logic_vector(2 downto 0);
    S_AXI_ARBURST           : in    std_logic_vector(1 downto 0);
    S_AXI_ARLOCK            : in    std_logic;
    S_AXI_ARCACHE           : in    std_logic_vector(3 downto 0);
    S_AXI_ARPROT            : in    std_logic_vector(2 downto 0);
    S_AXI_ARVALID           : in    std_logic;
    S_AXI_ARREADY           : out   std_logic;

    -- AXI Read Data Channel Signals (R)
    S_AXI_RDATA             : out   std_logic_vector(31 DOWNTO 0);
    S_AXI_RRESP             : out   std_logic_vector(1 downto 0);
    S_AXI_RLAST             : out   std_logic;
    S_AXI_RVALID            : out   std_logic;
    S_AXI_RREADY            : in    std_logic;
	
      --I/O - Port A
    BRAM_Rst_A             : out std_logic;  --opt port
    BRAM_En_A              : out std_logic;  --opt port
    BRAM_WE_A              : out std_logic_vector(3 DOWNTO 0);
    BRAM_Addr_A            : out std_logic_vector(14 DOWNTO 0);
    BRAM_RdData_A          : in std_logic_vector(31 DOWNTO 0):= (others => '0');
    BRAM_WrData_A          : out std_logic_vector(31 DOWNTO 0);
	
    
    BRAM_Clk_A             : out std_logic
	
	
	
);
END COMPONENT;


constant BMG_ADDR_WIDTH    : INTEGER :=  log2roundup(8192) + log2roundup(4);
constant PORT_ADDR_WIDTH   : INTEGER :=  log2roundup(8192);
signal BRAM_Clk_A    : std_logic;
signal BRAM_Rst_A    : std_logic;
signal BRAM_En_A     : std_logic;
signal BRAM_WE_A     : std_logic_vector(3 DOWNTO 0) := (others => '0');
signal BRAM_Addr_A   : std_logic_vector(14 DOWNTO 0) := (others => '0');
signal BRAM_WrData_A : std_logic_vector(31 DOWNTO 0) := (others => '0');
signal BRAM_RdData_A : std_logic_vector(31 DOWNTO 0) := (others => '0');
	
	
signal s_axi_aclk_buf : std_logic;
 
constant C_NB_COL : integer := 4;
constant C_COL_WIDTH : integer := 8;

-- Single Port RAM Configuration
 type mem_type is array (8192-1 downto 0) of std_logic_vector(32-1 downto 0);
 signal ram            : mem_type;
 



BEGIN

 ABC0 : axi_bram_ctrl_0
    
  PORT MAP (
       -- AXI Clock and Reset
    S_AXI_ACLK         =>         S_AXI_ACLK,--S_AXI_ACLK_buf,    
    S_AXI_ARESETN      =>         S_AXI_ARESETN, 

    -- AXI Write Address Channel Signals (AW)
    S_AXI_AWADDR        =>         S_AXI_AWADDR,  
    S_AXI_AWLEN         =>         S_AXI_AWLEN,  
    S_AXI_AWSIZE        =>         S_AXI_AWSIZE,  
    S_AXI_AWBURST       =>         S_AXI_AWBURST, 
    S_AXI_AWLOCK        =>         S_AXI_AWLOCK, 
    S_AXI_AWCACHE       =>         S_AXI_AWCACHE, 
    S_AXI_AWPROT        =>         S_AXI_AWPROT,  
    S_AXI_AWVALID       =>         S_AXI_AWVALID, 
    S_AXI_AWREADY       =>         S_AXI_AWREADY, 

    -- AXI Write Data Channel Signals (W)
    S_AXI_WDATA         =>         S_AXI_WDATA, 
    S_AXI_WSTRB         =>         S_AXI_WSTRB, 
    S_AXI_WLAST         =>         S_AXI_WLAST, 
    S_AXI_WVALID        =>         S_AXI_WVALID,
    S_AXI_WREADY        =>         S_AXI_WREADY,

    -- AXI Write Data Response Channel Signals (B)
    S_AXI_BRESP         =>         S_AXI_BRESP, 
    S_AXI_BVALID        =>         S_AXI_BVALID,
    S_AXI_BREADY        =>         S_AXI_BREADY,

    -- AXI Read Address Channel Signals (AR)
    S_AXI_ARADDR        =>         S_AXI_ARADDR, 
    S_AXI_ARLEN         =>         S_AXI_ARLEN,  
    S_AXI_ARSIZE        =>         S_AXI_ARSIZE, 
    S_AXI_ARBURST       =>         S_AXI_ARBURST,
    S_AXI_ARLOCK        =>         S_AXI_ARLOCK, 
    S_AXI_ARCACHE       =>         S_AXI_ARCACHE,
    S_AXI_ARPROT        =>         S_AXI_ARPROT, 
    S_AXI_ARVALID       =>         S_AXI_ARVALID,
    S_AXI_ARREADY       =>         S_AXI_ARREADY,

    -- AXI Read Data Channel Signals (R)
    S_AXI_RDATA         =>         S_AXI_RDATA, 
    S_AXI_RRESP         =>         S_AXI_RRESP, 
    S_AXI_RLAST         =>         S_AXI_RLAST, 
    S_AXI_RVALID        =>         S_AXI_RVALID,
    S_AXI_RREADY        =>         S_AXI_RREADY,
                           
	
      --I/O - Port A
    BRAM_Rst_A          =>        BRAM_Rst_A,      
    BRAM_En_A           =>        BRAM_En_A,    
    BRAM_WE_A           =>        BRAM_WE_A,    
    BRAM_Addr_A         =>        BRAM_Addr_A,  
    BRAM_RdData_A       =>        BRAM_RdData_A,
    BRAM_WrData_A       =>        BRAM_WrData_A,
    BRAM_Clk_A          =>        BRAM_Clk_A   
);


xpm_memory_spram_inst : xpm_memory_spram
  generic map (

    -- Common module generics
    MEMORY_SIZE        => (262144),  --2048,        --positive integer
    MEMORY_PRIMITIVE   => "block",      --string; "auto", "distributed", "block" or "ultra" ;
    MEMORY_INIT_FILE   => "none",      --string; "none" or "<filename>.mem" 
    MEMORY_INIT_PARAM  => "",          --string;
    USE_MEM_INIT       => 1,           --integer; 0,1
    WAKEUP_TIME        => "disable_sleep",--string; "disable_sleep" or "use_sleep_pin" 
    MESSAGE_CONTROL    => 0,           --integer; 0,1
    ECC_MODE           => "no_ecc",    --string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode" 
    AUTO_SLEEP_TIME    => 0,           --Do not Change


    -- Port A module generics
    WRITE_DATA_WIDTH_A => (32),  ---32,          --positive integer
    READ_DATA_WIDTH_A  => (32),  ---32,          --positive integer
    BYTE_WRITE_WIDTH_A => 8,  ---32,          --integer; 8, 9, or WRITE_DATA_WIDTH_A value
    ADDR_WIDTH_A       => PORT_ADDR_WIDTH,  ---6,           --positive integer
    READ_RESET_VALUE_A => "0",         --string
    READ_LATENCY_A     => 1,           --non-negative integer
    WRITE_MODE_A       => "write_first" --string; "write_first", "read_first", "no_change" 
  )
  port map (

    -- Common module ports
    sleep          =>  '0',

    -- Port A module ports
    clka           =>  BRAM_Clk_A,
    rsta           =>  '0',
    ena            =>  BRAM_En_A,
    regcea         =>  '0',
    wea            =>  BRAM_WE_A,
    addra          =>  BRAM_Addr_A(BMG_ADDR_WIDTH-1 downto (BMG_ADDR_WIDTH - 13)) ,
    dina           =>  BRAM_WrData_A,
    injectsbiterra =>  '0',
    injectdbiterra =>  '0',
    douta          =>  BRAM_RdData_A
    --sbiterra       =>  open,
   -- dbiterra       =>  open
  );








END xilinx;

