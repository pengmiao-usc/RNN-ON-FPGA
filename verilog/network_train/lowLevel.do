onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_network/clock
add wave -noupdate /tb_network/reset
add wave -noupdate /tb_network/newSample
add wave -noupdate /tb_network/dataReady
add wave -noupdate /tb_network/enPerceptron
add wave -noupdate /tb_network/inputVec
add wave -noupdate /tb_network/outputVec
add wave -noupdate /tb_network/networkOutput
add wave -noupdate /tb_network/modelOutput
add wave -noupdate /tb_network/resetP
add wave -noupdate /tb_network/dataReadyP
add wave -noupdate /tb_network/LSTM_LAYER/trainingReady
add wave -noupdate /tb_network/newCostFunc
add wave -noupdate /tb_network/J
add wave -noupdate /tb_network/Jpert
add wave -noupdate /tb_network/diffJ
add wave -noupdate /tb_network/costFunc
add wave -noupdate /tb_network/LSTM_LAYER/deltaCost
add wave -noupdate /tb_network/LSTM_LAYER/WRAM_Z_X/RAM_matrix
add wave -noupdate /tb_network/LSTM_LAYER/wZX_out
add wave -noupdate -radix binary /tb_network/LSTM_LAYER/PRAM_Z_X/RAM_matrix
add wave -noupdate /tb_network/LSTM_LAYER/bZ
add wave -noupdate /tb_network/LSTM_LAYER/bZ_out_gate
add wave -noupdate -radix binary /tb_network/LSTM_LAYER/sign_bZ
add wave -noupdate -radix unsigned /tb_network/LSTM_LAYER/state
add wave -noupdate /tb_network/LSTM_LAYER/WRAM_Z_Y/RAM_matrix
add wave -noupdate /tb_network/LSTM_LAYER/GATE_Z/gateOutput
add wave -noupdate -radix binary /tb_network/LSTM_LAYER/PRAM_Z_Y/RAM_matrix
add wave -noupdate /tb_network/LSTM_LAYER/wZX_out_gate
add wave -noupdate /tb_network/LSTM_LAYER/wZY_out_gate
add wave -noupdate /tb_network/LSTM_LAYER/pertWeights
add wave -noupdate /tb_network/LSTM_LAYER/wZY_out
add wave -noupdate /tb_network/LSTM_LAYER/wZX_in
add wave -noupdate /tb_network/LSTM_LAYER/wZY_in
add wave -noupdate /tb_network/LSTM_LAYER/sign_wZX
add wave -noupdate /tb_network/LSTM_LAYER/sign_wZY
add wave -noupdate /tb_network/LSTM_LAYER/colAddressTRAIN_X
add wave -noupdate /tb_network/LSTM_LAYER/colAddressTRAIN_Y
add wave -noupdate /tb_network/LSTM_LAYER/colAddressRead_X
add wave -noupdate /tb_network/LSTM_LAYER/colAddressRead_Y
add wave -noupdate /tb_network/LSTM_LAYER/colAddressRead_wZX
add wave -noupdate /tb_network/LSTM_LAYER/colAddressRead_wZY
add wave -noupdate /tb_network/LSTM_LAYER/prevLayerOut
add wave -noupdate /tb_network/LSTM_LAYER/PREVbZ
add wave -noupdate /tb_network/LSTM_LAYER/randGenOutput
add wave -noupdate /tb_network/LSTM_LAYER/randGenOutput_bias
add wave -noupdate /tb_network/LSTM_LAYER/genRandNum_X
add wave -noupdate /tb_network/LSTM_LAYER/genRandNum_Y
add wave -noupdate /tb_network/LSTM_LAYER/saveSS_layerC
add wave -noupdate /tb_network/LSTM_LAYER/N_PRNG
add wave -noupdate /tb_network/LSTM_LAYER/N_PRNG_BIAS
add wave -noupdate /tb_network/LSTM_LAYER/weightUpdate
add wave -noupdate /tb_network/LSTM_LAYER/writeWeightUpdate_X
add wave -noupdate /tb_network/LSTM_LAYER/writeWeightUpdate_Y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2149771517 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2147907999 ps} {2148257501 ps}
