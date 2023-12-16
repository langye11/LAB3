// ECE260A Fall 2022 Lab 3
// sample 4-input carry save adder, based on W&H Fig. 11.42 (p. 459) 
// always keep the same inputs and outputs and the same input and output registers
// try various versions of the combinational part, which executes sum = ar + br + cr + dr
module csa_with_cla #(parameter w=4)(
  input                       clk, 
                              reset,
  input        [w-1:0] a, 		// serial input -- filter will sum 4 consecutive values
  output logic [w+1:0] s);		// sum of 4 most recent values of a

  logic        signed [w-1:0] ar, br, cr, dr;
// combinational adder array -- this is what you should customize/optimize

  logic         [w:0] sum1;	
  logic         [w:0] tsum1;  // from final ripple adder

 logic         [w:0] sum2;
  logic         [w:0] tsum2;	  // from final ripple adder

 logic         [w+1:0] sum3;	  // from final ripple adder
 logic         [w+1:0] tsum3;


 inCLA #(.w(w)) first(
	.a(ar),
	.b(br),
	.s(sum1)
);

 inCLA #(.w(w)) second(
	.a(cr),
	.b(dr),
	.s(sum2)
);
always_ff @(posedge clk)			
    if(reset) begin					
	  tsum1 <=0;
	  tsum2<=0;
    end
    else begin					   
	 tsum1 <=sum1;
	tsum2<=sum2;
	end
 inCLA #(.w(w+1)) third(
	.a(tsum1),
	.b(tsum2),
	.s(sum3)
);
always_ff @(posedge clk)			
    if(reset) begin					
	  s  <= 'b0;
    end
    else begin					    
	  s  <= sum3; 
	end
// sequential logic -- standardized for everyone
  always_ff @(posedge clk)			// or just always -- always_ff tells tools you intend D flip flops
    if(reset) begin					// reset forces all registers to 0 for clean start of test
	  ar <= 'b0;
	  br <= 'b0;
	  cr <= 'b0;
	  dr <= 'b0;
	 
    end
    else begin					    // normal operation -- Dffs update on posedge clk
	  ar <= a;
	  br <= ar;
	  cr <= br;
	  dr <= cr;

	end

endmodule
