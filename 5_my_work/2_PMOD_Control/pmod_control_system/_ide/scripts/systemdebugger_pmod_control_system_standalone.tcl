# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\repo\SoC_Test\test3_led_pmod\vitis_proj\pmod_control_system\_ide\scripts\systemdebugger_pmod_control_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\repo\SoC_Test\test3_led_pmod\vitis_proj\pmod_control_system\_ide\scripts\systemdebugger_pmod_control_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351B4023BA" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351B4023BA-23727093-0"}
fpga -file C:/repo/SoC_Test/test3_led_pmod/vitis_proj/pmod_control/_ide/bitstream/system_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/repo/SoC_Test/test3_led_pmod/vitis_proj/soc_pmod/export/soc_pmod/hw/system_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/repo/SoC_Test/test3_led_pmod/vitis_proj/pmod_control/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/repo/SoC_Test/test3_led_pmod/vitis_proj/pmod_control/Debug/pmod_control.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
