README
======
This README points to the latest project I am working on at the moment. As I work on my home projects, only once in few months,
this README is important to be kept on track for my own benefits.

02/07/2023: 
===========
 * Revisting this folder to check where I was at last time
 * the porjects I am working on are 
    * arty-z7-hdmi : Rewrite the HDMI controller in verilog
    * arty-z7-uart : Rewrite this UART controller in system verilog

09/07/2023: 
===========
 * Progress on arty-z7-hdmi via project/arty-hdmi-graphics branch
   * Created the verilog codebase for rgb timing and pixel counter modules

30/07/2023: 
===========
 * Short Progress
  * Added code for DVI TX clock gen module

31/07/2023: 
===========
 * 1-hour weekday progress
  * Added system verilog package for functions- good learning

13/08/2023:
============
* Short 1-hour weekend progress
  * Added verilog code for oserdes & rgb_pattern modules--another good hands on learning

18/02/2024:
===========
* Coming back to home projects after 6 months.
* Project focus: arty-z7-hdmi => still on git branch arty-hdmi-graphics
  * Added verilog code for rgb_to_dvi and rst_bridge modules--good refresher and needs to do this more often

26/02/2024:
===========
* 1-1.5 hour weekend progress.
* Project focus: arty-z7-hdmi => still on git branch arty-hdmi-graphics
  * Added verilog code for the last two modules: sync_dff & tmds_encoder: No compile yet

03/03/2024:
===========
* 2-2.5 hour weekend progress.
* Project focus: arty-z7-hdmi => still on git branch arty-hdmi-graphics
  * Compiled the entire VHDL project on Vivado, downloaded to Arty board & checked on HDMI monitor. Didn't fully test though
  * Started compiling the Verilog project in Vivado. Fixed compile errors, all modules except two(rst_bridge & graphics_package) now green.

12/05/2024:
===========
* 1 hour weekend progress.
* Project focus:
  * Fixed the compile errors with rst_bridge & graphics_package modules. Used ChatGpt for fixing errors. Good learning on when and what to use ChatGpt
  * Started running through Vivado flow all the way to bitstream. Fixing synthesis errors on dvi_tx_clkgen.v

18/05/2024:
===========
* ~1.5 hour weekend progress.
* Project focus:
  * Fixed all the Vivado compile errors across all modules--good learning of Verilog vs VHDL. Now have 71 CRITICAL WARNINGS which needs attention next ime.

25/05/2024:
===========
* ~1 and quarter hour weekend progress.
* Project focus:
  * Fixed bunch of CRITICAL WARNINGS. But then reintroduced another set of CRITICAL WARNINS :-(). Now have 77 CRITICAL WARNINGS which needs attention next ime.

01/06/2024:
===========
* ~1.5 hour weekend progress.
* Project focus:
  * Fixed all the synthesis and implementation errors-good learning on Verilog always block variable usage. Downloaded bitstream to Arty board but nothing happened on HDMI monitor.

08/02/2025:
===========
* ~2.5 hour weekend progress.
* Project focus:
  * Debugged the verilog design by bringing up a Vivado simulation environment and comparing against VHDL version. Fixed a reset related bug which was propagating X's thereby invalidaing the outputs. 
