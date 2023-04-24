module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***Many operations and calculations performed within HDL begin, or end, based on the rising
//***edge of a signal. What is a rising edge? A rising edge is when a signal transitions from 
//***a low signal to a high signal, or from a 0 to a 1.

//***To identify the rising edge of a signal, we need to do two things. First, we need to track
//***the value of the signal from the previous clock cycle. Then, when the signal is currently 
//***high and it was low in the previous clock cycle, we have detected a rising edge. 

//***Below, we will detect the rising edges of wires wire1, wire2, and wire3. Using wire1 as an 
//***example, the RisingEdge automation will add a Previous automation and a p1_wire1 reg. The 
//***p1_wire1 reg will track the previous value of wire1 in an always block. Then,
//***wire1RisingEdgeWithItemName will be set to -> wire1 && !p1_wire1. This is, when wire1 is 
//***high, but p1_wire (wire1's value in the previous clock cycle) is low. Give it a try!
    

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
