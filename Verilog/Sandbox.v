module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset,

    input [15:0] input1,

    output [15:0] output1
);


//***Using verbose item name
/*[RisingEdge --signal input1]*/
wire input1RisingEdge;


//***Passing in the signal to track, inferred by position
/*[RisingEdge input1]*/
wire input1RisingEdgeByPosition;


//***Infer name, attached register starts with p1_
//*****ICII'S FAVORITE**
/*[RisingEdge]*/
wire risingInput1;
endmodule