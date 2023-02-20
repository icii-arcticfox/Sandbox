module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***Using verbose item name
/*[Previous --signal wire1]*/
reg wire1Previous;


//***Using item position to identify the signal
wire wire2;
/*[Previous wire2]*/
reg wire2Previous;


//***Infer name, p1_ prefix tells Arctic Fox wire3 is the signal
//***In the second Previous, p2_ prefix tell Arctic Fox it is the second previous, and p1_wire3 is the signal
//*****ICII'S FAVORITE**
wire wire3;
/*[Previous]*/
reg p1_wire3;
/*[Previous]*/
reg p2_wire3;
endmodule