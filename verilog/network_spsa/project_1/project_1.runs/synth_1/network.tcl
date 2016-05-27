# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg484-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/josefonseca/Documents/thesis/verilog/network/project_1/project_1.cache/wt [current_project]
set_property parent.project_path /home/josefonseca/Documents/thesis/verilog/network/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part xilinx.com:zc702:part0:1.2 [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  /home/josefonseca/Documents/thesis/verilog/network/dot_prod.v
  /home/josefonseca/Documents/thesis/verilog/network/weightRAM.v
  /home/josefonseca/Documents/thesis/verilog/network/sigmoid.v
  /home/josefonseca/Documents/thesis/verilog/network/gate.v
  /home/josefonseca/Documents/thesis/verilog/network/tanh.v
  /home/josefonseca/Documents/thesis/verilog/network/network.v
}
synth_design -top network -part xc7z020clg484-1 -mode out_of_context
write_checkpoint -noxdef network.dcp
catch { report_utilization -file network_utilization_synth.rpt -pb network_utilization_synth.pb }
