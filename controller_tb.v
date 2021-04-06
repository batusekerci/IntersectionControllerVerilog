`timescale 1ms / 1ms

module trafficlighttest();
    reg clk, rst, congdetector;
    wire[1:0] MR, SR;
    
    trafficlight UUT(MR, SR, congdetector, rst, clk);
    
    initial begin
    clk = 0;
    forever begin #5; clk = ~clk; end end
    
    initial begin
    rst = 1;
    congdetector = 0;
    #10;  rst = 0;
    #40000;congdetector = 1;
    #4000;congdetector = 0; 
    #33000;congdetector = 1;
    #2000;congdetector = 0;
    #13000;congdetector = 1;
    #2000;congdetector = 0;
    #38000;congdetector = 1;    
    #30000;congdetector = 0;
    #3000;congdetector = 1;    
    #47000;congdetector = 0;
    end
    
endmodule
