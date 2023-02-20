module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***Using verbose item name
wire wire1;
/*[RisingEdge --signal wire1]*/
wire wire1RisingEdgeWithItemName;


//***Using item position to identify the source
wire wire2;
/*[RisingEdge wire2]*/
wire wire2RisingEdgeByPosition;


//***Infer name, rising prefix tells Arctic Fox wire3 is the source
//*****ICII'S FAVORITE**
wire wire3;
/*[RisingEdge]*/
wire risingWire3;
endmodule