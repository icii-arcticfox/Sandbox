module Sandbox(
    /*[Clock]*/ input clk,
    /*[Reset]*/ input reset
);


//***The Counter automation was designed to make it faster and easier to create, you guessed it, counters!


//S***Specify Count, Start, and Done
//***Use case: Let's assume we have a calculation that takes 50 clock cycles to finish. Once we receive the
//***startCalculation pulse, we want to start our counter. After 50 clock cycles we want to save the result
//***of the computation.

wire startCalculation1;
wire calculation1Finished;
/*[Counter --count 50 --start startCalculation1 --done calculationF1inished]*/
reg [15:0] counter1;



//S***Specify Count and Start, but not Done
//***Use case: Often we want to specify when to start a counter, and how much to count to, but don't care to
//***specify the name of the done signal. In t_his case, we can use the Value Identifier (see Value sandbox)
//***to get the generated name of the done signal. We'll use the same setup as previously, but assume we need
//***to count to 100.

wire startCalculation2;
/*[Counter --count 100 --start startCalculation2]*/
reg [15:0] counter2;

//***To show thuse of the Value Identifier, let use it in an assign statement.
wire proceedToNextStep = /*[$counter2.done]*/;



//S***Dynamic Count Amount
//***Use case: Often the amount we want to count will depend on the state of the system or a register that
//***has been set. Above, we specified hard count values of 50 and 100. This time, we will assume we have
//***a register, userSetCount, that a processor would set. The counter will count up to t_his register.

reg [31:0] userSetCount;
wire startCalculation3;
/*[Counter --count userSetCount --start startCalculation3]*/
reg [23:0] counter3;



//S***Start Counter, Infinitely Count Up
//***Use case: Other times we want to start counting after a start signal and track the time since the signal.
//***The no max item, --nomax, will enable the counter to continuously count. Please note, if the counter
//***reaches the max value for the counter's bit width, it will be held at that maximum value.

wire startCalculation4;
/*[Counter --start startCalculation4 --nomax]*/
reg [15:0] counter4;



//S***Counting Events, not Clock Cycles
//***Above, we increased the counter each clock cycle, a common use case. However, other time we want to
//***count how many times a signal is seen. In t_his case, we can use the --event item rather than
//***the --start item.

//***Use case: Below, we have a signal, risingTX. We assume we are receiving serial bits that we want to
//***turn into a parallel byte. We want to count 8 risingTX signals.

wire risingTX;
/*[Counter --count 8 --event risingTX]*/
reg [15:0] counter5;



//S***Counting Infinite Events
//***Use case: Similar to conting infinite clock cycles, sometimes we don't want to limit the number of
//***events we want to count. Similar to the previous infinte count, if the counter reaches the maximum
//***value for it's bit width, it will hold that value. Below, we assume we are counting the number of
//***anomalies we encounter.

wire anomaly;
/*[Counter --event anomaly --nomax]*/
reg [31:0] counter6;
endmodule