module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***This sandbox uses the always automation and non-blocking automation together


//S***Traditional Use
//***Use case: One of the challenges to create digital logic efficiently is to prevent simple bugs that
//***can consume large amounts of time to debug. This can easily happen when we have groups of similarly
//***named variables that we assign values to. Frequently, we have copied signals from one block, updated
//***most of the new block correctly, missed one change, and spent several hours trying to figure out
//***what was wrong.

//***One of the goals of Arctic Fox is to make code more readable. Please observe how much less cluttered
//***the written code is.

//***For t_his example, we will have a counter that can be set to an initial value and incremented by a
//***pulse, as described below.

wire [15:0] initialValue; //The initial value the counter will assume
wire resetToInital; //Signal to set the counter to the initial value
wire increment; //Signal to increment the counter

//***The example will also illustrate the following concepts:
//***- always automation, /*[always]*/ names the left hand value for the block
//***- non-blocking automation, /*[<=]*/, will set the value given to /*[always]*/ to what's passed into /*[<=]*/
//***- Not passing a value into /*[<=]*/ will hold the current value
//***- Using "this" in the automation will use the name of the value given to /*[always]*/

reg [31:0] countReg;
/*[always countReg]*/ begin
    if(reset)
        /*[<= 0]*/
    else if(resetToInital)
        /*[<= initialValue]*/
    else if(increment)
        /*[<= this + 1]*/
    else
        /*[<=]*/
end



//S***Copy and Paste
//***Use case: Often, we want to apply the same logic, or similar logic, to multiple signals. With the
//***always and non-blocking automations, we can copy and paste the block, change the name passed into
//***the always automation, and it works. Let's copy and paste the code, and only change countReg to
//***a new name, say, newCounter;

reg [31:0] newCounter;
/*[always newCounter]*/ begin
    if(reset)
        /*[<= 0]*/
    else if(resetToInital)
        /*[<= initialValue]*/
    else if(increment)
        /*[<= this + 1]*/
    else
        /*[<=]*/
end
endmodule