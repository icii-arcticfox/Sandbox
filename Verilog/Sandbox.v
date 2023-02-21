module Sandbox(
    /*[Clock]*/ input clk
);


/*[Reset None]*/ //Set to None to make example generated code shorter

//***Values are an Arctic Fox construct that make it easier to move information back and forth Verilog
//***and the C# environment. Below, we show a few ways to use Values.

//***We cover many different uses of Values, but possibly, the greatest use is the last one, where
//***Values turn Verilog into an object oriented language!



//S***Basic Value Use
//***One of the most straight forward ways to use Values is to set the value and recall it elsewhere.
//***You can use the SetValue automation to set the value, and reference a value with the $. Below,
//***we set totalDelay to 4 and then recall it in the Delay automation by referencing the value
//***with the $totalValue notation.

/*[SetValue totalDelay 4]*/ //Set totalDelay to 4

wire [7:0] initial1;
/*[Delay --name initial1 --delay $totalDelay]*/
wire [7:0] delayed1;



//S***Set Value Shortcut
//***For many Arctic Fox features, we got tired of writing verbose names and phrases, so we created
//***shorthand expressions. SetValue is no different. You can shortcut t_his by just using the $ as
//***the first character in the automation as seen below.

/*[$newDelay 2]*/

reg [7:0] initial2;
/*[Delay --name initial2 --delay $newDelay]*/
wire [7:0] delayed2;



//S***Global Values
//***Another benefit of Values is that they can be used across Verilog files, these are called global
//***Values. Global values start with the character ^. Non-global values are accessible only within the
//***modules they are created. Values created in C# are by default global.

/*[$^globalValue 3]*/

reg initial3;


/*[Delay initial3 $^globalValue]*/
wire delayed3;



//S***Direct Use
//***The previous examples referenced Values within other automations. However, Values can also be used
//***by themselves. Doing so will place the value of the Value directly in code. You might wonder how
//***t_his differs from parameters or macros:
//***- the value of a Value can be calculated in software and determined by anything, really
//***- the value of the Value is placed directly in your code, making it easier to debug
//***- t_his opens the door to a more object oriented design, as shown shortly

/*[$incrementAmount 3]*/

wire [15:0] userReg;
wire [15:0] addedToUserReg;
assign addedToUserReg = userReg + /*[$incrementAmount]*/;



//S***Using a String as a Value
//***The previous examples all used numbers as the value of a Value. However, t_his doesn't have to be the
//***case, and strings can also be the value.

/*[$signalToAdd multiplyResult]*/
wire [31:0] initialSum;
wire [31:0] finalResult = initialSum + /*[$signalToAdd]*/;



//S***Object Oriented Verilog
//***One of our favorite ways to use Values is to make Verilog object oriented. Let's take the example of a
//***rising edge. To detect the rising edge of a signal we can easily use the RisingEdge automation. Now, it
//***would be challenging if we had to always remember what signal names an automation will create, etc. But,
//***fortunately, we don't have to. Instead, a RisingEdge automation, using Values, attaches a "rising"
//***property to the original signal. The "rising" property will always be used the same, regardless of the
//***original signal, enabling us to easily interact with the automations, and objects, we've created.

//***The examples below are minimal as t_his feature within Values is very new.

wire gainPulse;
/*[RisingEdge --signal gainPulse]*/
wire risingEdgeOfGainPulse;

wire enableGainPulsing;
wire pulse;
assign pulse = enableGainPulsing && /*[$gainPulse.rising]*/;

//***Another example is when using a counter. We can refer to the "done" property of a counter to know when
//***it has finished counting.

wire startCounting;
/*[Counter --count 50 --start startCounting]*/
reg [7:0] myCounter;

wire nextStep;
assign nextStep = /*[$myCounter.done]*/;
endmodule