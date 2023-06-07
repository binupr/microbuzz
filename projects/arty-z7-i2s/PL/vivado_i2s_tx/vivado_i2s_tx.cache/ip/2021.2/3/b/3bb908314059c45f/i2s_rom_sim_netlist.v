// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Sat Nov 20 15:50:34 2021
// Host        : binupr-home-nuc running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ i2s_rom_sim_netlist.v
// Design      : i2s_rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "i2s_rom,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2021.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [6:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [15:0]douta;

  wire [6:0]addra;
  wire clka;
  wire [15:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [15:0]NLW_U0_doutb_UNCONNECTED;
  wire [6:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [6:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [15:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "7" *) 
  (* C_ADDRB_WIDTH = "7" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.7096 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "i2s_rom.mem" *) 
  (* C_INIT_FILE_NAME = "i2s_rom.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "100" *) 
  (* C_READ_DEPTH_B = "100" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "16" *) 
  (* C_READ_WIDTH_B = "16" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "100" *) 
  (* C_WRITE_DEPTH_B = "100" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "16" *) 
  (* C_WRITE_WIDTH_B = "16" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[15:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[6:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[6:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[15:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oESHD2Q5NORrmTVTCApB+YFZJwjA1ezq7U6VZh96by+ofPCvSFp06AIoCLvB4BhPvxfob6kIkBpR
xVCOLM7HsDk7nO1JVWiYIJ6okoWTA8hAlPj3sdGuMwRlZNSBKn/c6F+CW5Jl37TEGotkhycSB3Bg
B/uu1THUZwIG87RPahE=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RovEhaqHrFqzjckk+DIWG8LQeqg2Y/nACQDyXKKtSav7YHlgpKmgHZnsxwwNpqrqVRGyjTecSQ+e
6Mr/Pi9au3AgJVPL6VOgwNVE0yj2LpA4LPyWzxLN3+DiSDmsaCBNCBlVQi2MRKUabou8nLaXldbL
+7pv4pYhQdcyjDzuC2dx3HmzADqstdEiyXeU3ktJ29CDLDmGwDWdmsrl90s4YQSfBV2nj4/Vut3L
p/8dzphf1htPaNMujMxxgp3z4JzUEDJJokDL+gNutEEHiaWpI3URIA5v22vJu+NPD+eEraSioHfL
DPKAajZTwK5FHnonu4O2D0co8GWqWW5cUqZz9A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jBQ6Th9yy7jtKQD1h235YLT6qO6XiBaBKGJrV1Z8H9M9ePJ9R/fA8E1okt4LyBvoWjR7tmCbIg7A
0/vuKOogkLtDE/BtTlp4z1iurO8rQrAcdZy/e+7GATawyJxFY7kZhnXASu9zB8TiOBELSlapkpxe
WuAzXLde9FBMBkq4RSc=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eucSNV2Zbm4zYc2tIGRlGmlVM8+WHY1NHe9drZdgDhGPOHz8PTqHapfnZ1kWuTLtPBLSMvcXNScn
UTvpULofBV6qD7WHLPg7UJcjpZVDL69lk88chgqrlc/RqaJXKNVv+Ubku53ZLU20uZK71bNymjSM
855RVWw5lvTHTCNC2MYIS94Fmrzuq8i0+tFh5qBKkHK2BC+fD7xVyyfuh4mZR2yr/hRs/emoI79E
IKoJnLiglVp6RXTsXFzZW4pIthbjWSuZlOQvoYkS2RMj8a0r9lyariphRQunoudc0bLO4Phk578c
40gusaaS/MI7idMT7k1Di96kvu5mHi23loRcZQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E/syLaRG2Ss/xTTkuAkOKXzm53+rCptYO2DkVukWhvlLmEB2daHCPrXt4gKeuG+0hIGWedSwCiLJ
7KNtEAiTumJ/j+3p7s3oXN9ftCSRolXoACsCclEAmwYjVM0ubCXUx6JNFOGt0yDl2Jsd5+W10mSJ
bYEKvRKi7koXM/eYJqbhTrtsrHDwRJEY0JVUPh8EOkLLqaIKbnjb6ENEY6qZOamp5PaWsSS30gJM
N6fB8D1AmGKnFbfY+d5TexS55Z92aYcAHNX2XwHsKnm45az1vHeZ0rTEU/oONIaSZfikRni1iDBg
x2GOue6sLiwxTEHaVkTJsOVR4mx0VsfFxavwRg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
dSHHpkQiOEzzKs4D71WVyDXLpkKuR9h9h3pBLtnCq2bXiwE/eQHmk5HeQb+qREg0Yv193OukqaQz
RZyuF5GQcqOpqFHMxO62HQ2pdjdpMT5CC7gHvmgiw9qBkJJrXpihIHER4X7OF2iNUfeqxJ8eiSz3
C0V20NlIwKG7Mxg8MVj++xmb32KMUqL7ptikkym20vVdhecVMNvpPoXp8uvaGT7991enWP9HGKUC
9kLY2DEYwRGE71UJJLGWo4n49R50ExFRj91xWnYfvp7uJsMNwnBp5l3GTZiMELX2RkRVSPOHr7l1
n2p5Vq7Uee2drny1IxZ/4c0hYY6y3QWSEqpESw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
HUtfqZ9dh5oZTOAt9a0ebo+wQbzg3izFQ0kVqZN81S4cBjQEF53WUiVlTKBDVjvLNUby4Se9WZjj
j86TQzuGJxLPDTohmbytErsg5JrlXHbHGwR4zGNGTbBs12X7PkxtS8wVCp+7b1rX6pOGOPqm6FoG
g6rZY/bTzVfGYF2CAOhjJUqUOXEAKnZRehspRyiBI28/ZZPSAUD/abKprW8PWCxMx2zPWztZz4No
R96jgvHezNzB1Ta8W7uRBFTMp+XVSToxTp2jzSXJZ0V5xJl+gdVjAMmf6+te2vqrK2wDWdMxk3Sf
iyLI4d0s25vCybcY2fZWacq5iO9pSlSaOQWgCA==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
vYYu2Kvhv3RZi0pFbjRTQ/BBwfilCrGpkMls+Dz6HBGTZvSaC/anWgymoDS0XnoSENGG3Pz3EBF0
19OqLbyna95IHFe2bA7f8RgU9SEUffZ8eXGigfOjAWpZCN07Q77RkhGUKal7okWe3Q6xHtZy83l2
kW8ma3kOYL7GzQjtpbP3lINHLMqpGEo0dzbOHiJ5r6W5U6DsILGsoLQOXcw+MwrevvNRB0KkSklj
QnL8K2AK8PIsJGM6F8dj5KwRYhSBYNb1opuVpiJWlbHgADoeM+dhiRxBLmnaDE8PWs1ReY6uMzzH
SvvO6UEyxQtvS/Smm/uogr1eUFedUaBHPMEXnYlTAv/SKrh942GeknsqfrjGkZxWTN2NEnvpRUwT
fS0pyd/Err0s94b0srmcTYyxZfJGRUct2T8MCphZFaScAlhn655pxW9RaHMfcvDJUHpW8Qa+KhRt
9CWYScPIH6YNDByLQbhKL5BTpAYMNYPF2W7vM2ZzDob2NB7m6GGeKRr3

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QSNmIeTT4pBji+CTjknWXN6sH9Wff8+t8KF+AC3fIoIw08jtLtShcB9ZGeEKG02RGCO4lNIUf5YB
2TVYk6EJ5XyCav12qDhc60n56UVrnpfo7drorY0NmOypuxECgO43h6SDWp9W7px3r4CJnQ4+X2Mj
943GdP30WfL5kbWHZJC1Dz9cBIqRa1EbNXvvAqBvRPS2+aXBXAPOC4rNVZGeIUspn/33IW3yJLSp
Jm5GIct87ZuSoz8+DXhUvsTj4hq8lgirVhfz1qhHm8SfODcE91FGUPw3vbpGWXsBX73t2zxFC1Hz
/6m4YqQJVxd+H5iGE4kbHxHyHnH7FIerqc8Phw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UhfxKxECbuHK/o9ZExa2zP/MIPmFXuDNZwgpiawuBmPeRI1nJsYB7vzbBGMPKny4yIHLT8mHrQRc
fs05atkjIAbLea4+WNoCdCeg7/0PzuodM1ol3it6BHQ6Yzq4mnZbzlk8Xtwmk8ACAbzOr2SYxYWX
ueuUlimUSRusIe4+NiPvzbfHMAOVPjdmSY7zaSyeJuhdAR+fUGeHy5B23Xe2X6cDPeJ75IqcBeul
ox3dTXi3L8r/s1bTKX3FhxRyPZuh/xCWuEajsF2fEYdwWHKtLX6IQniLBJ5ZnVSS8D7IYPsvV4t0
9rWJqto5O1n3rAM44OvKvc9pOYXJupuv7g3gWg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fmo66vhS7nigYtLDMjdj7hgUnDG/fnO+cIaY/3qHrcwT7u/paj5enLuWHovegu9O9WRq3pPNnjuN
6vZRpuCgz5p4VAV7dVg9fuzg99BAjThp1Q/+HIPfdQ2LM14ZpTh4FXxthHGkTyS5PJArvZ3/UMpW
zwfdYd5+k2/emJ4/nuqoJHQG8k+O5EjSprLTvNZ/wrE1cT/fW/Lu2pxI4msHqVVYAXz7sJ13cQ+C
7tKxCV8vTyf0rpStdE+kZXg+jrc7vFKuPJO0U9axMsC0nXyeYx2jzfAHptGWKvfQaPg/Eo9mgLyN
qSJfFS6aIycuxNmg7L82WK401aWhnUn7GNrudg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19808)
`pragma protect data_block
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
CR1U3DbpaAbaV4xKsz3FZcaxzgI0nde1ljsliXA=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
