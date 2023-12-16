module inCLA #(parameter w=4)(
  input         [w-1:0] a,
  input         [w-1:0] b,
  output logic  [w:0] s);


logic [w : 0] C;

always_comb begin
C[0] = 0;
	
	for(int i=1;i<w+1;i++) begin
		C[i] = a[i-1] & b[i-1] | ((a[i-1] ^ b[i-1]) & C[i-1]);
	end

end

always_comb begin
	for(int i=0;i<w;i++)begin
		s[i] = a[i] ^ b[i] ^ C[i];
	end
	
	s[w] = C[w];
end
endmodule