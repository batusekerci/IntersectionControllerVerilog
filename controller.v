`timescale 1ms / 1ms

module trafficlight(MR, SR, congdetector, rst, clk);
    input congdetector, rst, clk;     
    output[1:0] MR, SR;             // MR - main road  SR - side road 
    reg[11:0] seccount;
    reg[1:0] State;
    reg[6:0] clkcount;
    reg condetected = 0;
    
    assign MR = State;
        
    always@(posedge clk)begin
    if(congdetector) condetected <= congdetector; 
    end
    
    always@(posedge clk) begin
    if (rst)begin 
    State <= 2'b00;
    seccount <= 1; 
    clkcount <= 1; 
    end
    else 
    clkcount <= clkcount + 1;
    if (clkcount == 100)begin
    clkcount <= 1; 
    seccount <= seccount + 1; 
    end 
    end 
    
    always@(posedge clk)begin
    case(State)
        0:begin if(seccount>=20 &~condetected )begin 
        clkcount <= 1;
        State<= 2'b01;
        seccount <= 1;  
        end
        else if(seccount>=40 &~congdetector)begin 
        condetected<=0;
        State<= 2'b01;
        seccount <= 1; 
        clkcount <= 1;
        end
        else State <= 2'b00;
        end
        1:begin if(seccount>=3)begin 
        State <=2'b10;
        seccount <= 1; 
        condetected<=0;
        clkcount <= 1;
        end 
        else State <= 2'b01;
        end
        2:begin if(seccount >= 10 | congdetector )begin 
        condetected<=0;
        State <= 2'b11;
        seccount <= 0; 
        clkcount <= 1;
        end
        else State <= 2'b10;
        end
        3:begin if(seccount>=3)begin 
        State <= 2'b00;
        seccount <= 0;
        condetected<=0; 
        clkcount <= 1;
        end 
        else State <= 2'b11;
        end
        default:begin 
        State <= 2'b00;
        condetected<=0; 
        seccount <= 0; 
        clkcount <= 1; 
        end
    endcase
    end
endmodule
