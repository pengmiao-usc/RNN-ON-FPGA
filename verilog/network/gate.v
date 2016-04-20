module gate     #(parameter INPUT_SZ  = 8,
				  parameter HIDDEN_SZ = 16,
				  parameter QN = 6,
                  parameter QM = 11,
				  parameter DSP48_PER_ROW = 2)
                 (inputVec,
                  prevLayerOut,
                  weightMem_X,
                  weightMem_Y,
                  biasVec,
                  beginCalc,
                  clock,
                  reset,
                  colAddress_X,
                  colAddress_Y,
                  dataReady_gate,
                  gateOutput);
   
	// Dependent Parameters
    parameter BITWIDTH         = QN + QM + 1;
    parameter LAYER_BITWIDTH   = BITWIDTH*HIDDEN_SZ;
	parameter ADDR_BITWIDTH_X  = $ln(INPUT_SZ)/$ln(2);
	parameter ADDR_BITWIDTH    = $ln(HIDDEN_SZ)/$ln(2);
	
	// State tags
	parameter IDLE       = 3'd0;
	parameter CALC_XandY = 3'd1;
	parameter SUM_X      = 3'd2;
	parameter CALC_Y     = 3'd3;
	parameter SUM_Y      = 3'd4;
	
	// Input/Output definition
	input signed        [BITWIDTH-1:0]  inputVec;
	input signed        [BITWIDTH-1:0]  prevLayerOut;
	input signed  [LAYER_BITWIDTH-1:0]  weightMem_X;
	input signed  [LAYER_BITWIDTH-1:0]  weightMem_Y;
	input signed  [LAYER_BITWIDTH-1:0]  biasVec;
	input signed                        beginCalc;
	input                               clock;
	input                               reset;
	output wire        [ADDR_BITWIDTH_X-1:0] 	colAddress_X;
	output wire        [ADDR_BITWIDTH-1:0]  colAddress_Y;
	output reg	    					    dataReady_gate;
	output reg signed [LAYER_BITWIDTH-1:0]  gateOutput;
	
	// Internal Registers
	wire signed [LAYER_BITWIDTH-1:0] outputVec_X;
	wire signed [LAYER_BITWIDTH-1:0] outputVec_Y;
	reg signed [LAYER_BITWIDTH-1:0] adder_X;
	wire dataReady_X;
	wire dataReady_Y;
	wire reset_dotProd_X;
	wire reset_dotProd_Y;
	reg [2:0] state;
	reg [2:0] NEXTstate;
	integer i;

    // Control signals 
    reg enable_dotprodX;
	reg enable_dotprodY;
	
	// Logical OR between the enable signals and the global reset
	assign reset_dotProd_X = reset || !enable_dotprodX;
	assign reset_dotProd_Y = reset || !enable_dotprodY;
	
	// DUT Instantiation
    dot_prod  #(HIDDEN_SZ,INPUT_SZ,QN,QM,DSP48_PER_ROW)  DOTPROD_X (weightMem_X, inputVec, clock, reset_dotProd_X, dataReady_X, colAddress_X, outputVec_X);  
    dot_prod  #(HIDDEN_SZ,HIDDEN_SZ,QN,QM,DSP48_PER_ROW) DOTPROD_Y (weightMem_Y, prevLayerOut, clock, reset_dotProd_Y, dataReady_Y, colAddress_Y, outputVec_Y);
    

	
	// Resets the gate registers
	always @(posedge reset) begin
		gateOutput <= {LAYER_BITWIDTH{1'b0}};
		adder_X    <= {LAYER_BITWIDTH{1'b0}};
	end
	
    // The bias and X sum unit
    always @(posedge dataReady_X) begin
		for (i = 0; i < HIDDEN_SZ; i = i + 1) begin
			adder_X[i*BITWIDTH +: BITWIDTH] <= outputVec_X[i*BITWIDTH +: BITWIDTH] + biasVec[i*BITWIDTH +: BITWIDTH];
		end
	end
    
    // The X and Y sum unit
    always @(posedge dataReady_Y) begin
		for (i = 0; i < HIDDEN_SZ; i = i + 1) begin
			gateOutput[i*BITWIDTH +: BITWIDTH] <= adder_X[i*BITWIDTH +: BITWIDTH] + outputVec_Y[i*BITWIDTH +: BITWIDTH];
		end
	end
    
    // The FSM that controls the gate
    always @(posedge clock) begin
		if (reset == 1'b1) begin
			state <= 3'd0;
		end
		else begin
			state <= NEXTstate;
		end
	end
	
	// Combinational logic that produces the next state
	always @(*) begin
		case(state)		
			IDLE :
			begin
				if ( beginCalc == 1'b1)
					NEXTstate = CALC_XandY;
				else
					NEXTstate = IDLE;
			end
			CALC_XandY :
			begin
				if (dataReady_X == 1'b1)
					NEXTstate = SUM_X;
				else 
					NEXTstate = CALC_XandY;
			end
			
			SUM_X :		
				NEXTstate = CALC_Y;
				
			CALC_Y :
			begin
				if (dataReady_Y == 1'b1)
					NEXTstate = SUM_Y;
				else
					NEXTstate = CALC_Y;
			end
			
			SUM_Y :
				NEXTstate = IDLE;
				
			default:
				NEXTstate = IDLE;
		endcase
	end
	
	always @(*) begin
		case (state)
			IDLE :
			begin
				enable_dotprodX = 1'b0;
				enable_dotprodY = 1'b0;
				dataReady_gate  = 1'b0;
			end
			
			CALC_XandY:
			begin
				enable_dotprodX = 1'b1;
				enable_dotprodY = 1'b1;
				dataReady_gate  = 1'b0;
			end
			
			SUM_X :
			begin
				enable_dotprodX = 1'b0;
				enable_dotprodY = 1'b1;
				dataReady_gate  = 1'b0;
			end
			
			CALC_Y :
			begin
				enable_dotprodX = 1'b0;
				enable_dotprodY = 1'b1;
				dataReady_gate  = 1'b0;
			end
			
			SUM_Y :
			begin
				enable_dotprodX = 1'b0;
				enable_dotprodY = 1'b0;
				dataReady_gate  = 1'b1;
			end
		endcase
	end
		
endmodule