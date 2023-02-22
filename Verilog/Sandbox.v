//***Connections between PS and PL portions of an FPGA have become an integral part of
//***software/hardware codesign systems. One of the popular bus choices is AXI. However,
//***AXI connections are not trivial and modifying AXI registers can be time consuming.
//***To make it easier, we create the set of External / AXI automations. External can be
//***used for a variety of bus types, but for now, we'll focus on AXI.

//***Using these automations, you can declare a module as an external connection, and then,
//***any reg/wire in that module or a sub-module with an External automation attached will
//***be exposed automatically through the AXI bus.

//***Below, the Sandbox module is the top level, marked with ExternalConnection, and
//***---axi4LiteSlave identifies the connection as an AXI Lite Slave. Then, DataProcessor
//***and DataParser are instantiated as sub-modules.

//***Within DataProcessor, the following regs are External: dataCount, algorithmCode, filter1,
//***and filter2. Additionally, these are marked with BasicAxiReadWrite which will generate
//***code that enables them to be read from and written to by the PS.

//***Within DataParser, the following wires and regs are marked External: newDataFrame,
//***syncPulse. newDataFrame and syncPulse are marked with --pulse meaning they will pulse
//***high when the PS performs a write to the reg. dataProcessorReady and parsingError are
//***marked with Interrupt and will be AXI interrupts.

//***One of the important things to observe is how Arctic Fox generates the code within the AXI
//***receiver module. For each External and Interrupt variable, code is generated to route the
//***signal correctly and generate read and write signals and logic. Once you run Arctic Fox, 
//***a module will be generated, Axi4ListSlaveInterface_DefaultGroup, that implements the AXI 
//***receiver and will be instantiated under Sandbox. 

//S***What To Do In This Sandbox
//***- Run Arctic Fox
//***- For each reg / wire marked with External / Interrupt, look at the generated code within
//***  Axi4ListSlaveInterface_DefaultGroup for the code that matches the reg / wire name
//***- Add a reg / wire to one of the modules, attach an External automation to it, and look 
//***  at the code within Axi4ListSlaveInterface_DefaultGroup for the new reg / wire



//[ExternalConnection --axi4LiteSlave]
module Sandbox(
    /*[Clock]*/ input clk
);


DataProcessor dataProcessor(
);

DataParser dataParser(
);
endmodule

//******************************************
//******************************************
//******************************************
module DataProcessor(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox S_AXI_ARESETN]*/ wire reset;

/*[External]*/
/*[BasicAxiReadWrite]*/
reg [31:0] dataCount;

/*[External]*/
/*[BasicAxiReadWrite]*/
reg [3:0] algorithmCode;

/*[External]*/
/*[BasicAxiReadWrite]*/
reg [15:0] filter1;

/*[External]*/
/*[BasicAxiReadWrite]*/
reg [15:0] filter2;
endmodule

//******************************************
//******************************************
//******************************************
module DataParser(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox S_AXI_ARESETN]*/ wire reset;

/*[External --pulse]*/
wire newDataFrame;
/*[External --pulse]*/
wire syncPulse;

/*[Interrupt]*/
reg dataProcessorReady;
/*[Interrupt]*/
reg parsingError;
endmodule
