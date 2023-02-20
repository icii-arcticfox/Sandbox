module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***Using verbose item name
/*[Previous --signal input1]*/
reg input1Previous;


//***Passing in the signal to track, inferred by position
/*[Previous input1]*/
reg input1Previous;


//***Infer name, attached register starts with p1_
//*****ICII'S FAVORITE**
/*[Previous]*/
reg p1_input1;
//***You can build on successive Previous automations by incrementting the suffix to p2_
/*[Previous]*/
reg p2_input1;


endmodule