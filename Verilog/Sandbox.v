module Sandbox(
    /*[Clock 100 MHz]*/ input clk,
    /*[Reset]*/ input reset
);


wire startingWithCommentsWasCausingAnIssue_TemporaryWire;

//S***Routing signals
//***The description here got pretty long, hand with us and you'll be able to see what we love about the 
//***routing automation.

//***Routing signals through a design is one of the tasks that can easily be underestimated. If a system has
//***only a few modules, or litte hierarchy, it's not a huge issue. But, when the hierarchy grows, or, you
//***have to make changes, and sometimes, very large changes, routing and re-routing can become a huge pain!
//***Furthermore, make large, quick changes for debugging, logic analyzers, experimentation, etc. are very
//***challenging and prevent potential growth.

//***Because of the challenges described above, and the struggles we've faced when routing hundreds of signals
//***in fully custom designs, we wanted routing to be way, way easier. We wanted to just mark the endpoint of
//***a route and say, get the signal from t_his other module or module instance. So that's what we created.

//***In t_his example, modules A and B are instantiated directly under Sandbox. Modules AA amd AB are instantiated
//***under module A, ABA, ABB, and ABC are instantiated under AB, etc. as the pattern describes. Each module
//***creates one wire with a name equal to the lowercase equivalent of the module name. Module ABA has a wire aba,
//***etc.

//***Finally, module BA routes wire aba from module ABA, wire abb from module ABB, and wire abc from module ABC to
//***itself. A few other modules also route some signals.

//***Additionally, each submodule connects to clk and reset from the top level module Sandbox. Not demonstrated, but
//***what often happens, is that a top level module is named by a Value, so if the top level module changes, all
//***clock and reset signals will instantly be routed to from a different module. Furthermore, routing to a signal
//***that has a Clock or Reset automation attached will apply those properties to the receiving module. This is
//***demonstrated in module BB where a Previous automation is used. The always block for p1_bb uses the clk and
//***reset signals even though the Clock and Reset automations are not used within the module directly. The whole
//***point of t_his - you can define your clock and reset automations / signals in one spot, and use it through your
//***design without having to continually retype the clock and reset automations.

//***To use the routing automation, or formally called /*[Import]*/, you just use /*[.ModuleName]*/ followed my your wire
//***definition. You can see t_his below in module BA with the following line: 
//***/*[.ABA]*/ wire aba;
//***ABA is the module that the source is routed from, and since no name is given, the same name, aba is assumbed, 
//***and the signal is routed to wire aba in module ABA. 

//***You can also route a signal with a different start and stop name as follows: 
//***/*[.ABA myStartWire]*/ wire aba;
//***Here, the signal myStartWire in module ABA will be routed to wire aba in the current module that contains the 
//***automation and wire definition. 

//***There are many other options when using the routing automation, flopping the signal, delaying the signal, 
//***one to many routing, many to one routing, etc., but for now, we are just focused on showing you the basics of
//***one to one signal routing. 

//***Lastly, you'll notice that the module declarations have nothing wired to their ports before running Arctic Fox
//***and applying the automations. This is because, once you start using the routing automation efficiently, you no 
//***longer need to manually route connections, Arctic Fox does it for you. 

//***Play around with the code below, add wires, route new wires, etc. and get a feel for automated routing!


A instanceA(
);


B instanceB(
);
endmodule


//***************************************
module A(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

AA instanceAA(
);

AB instanceAB(
);

wire a;
endmodule


//***************************************
module AA(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

wire aa;
endmodule


//***************************************
module AB(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

ABA instanceABA(
);

ABB instanceABB(
);

ABC instanceABC(
);

wire ab;
endmodule


//***************************************
module ABA(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

wire aba;
endmodule


//***************************************
module ABB(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

wire abb;
endmodule


//***************************************
module ABC(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

wire abc;
endmodule




//***************************************
module B(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

BA instanceBA(
);

BB instanceBB(
);

BC instanceBC(
);

wire a;
endmodule


//***************************************
module BA(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

/*[.ABA]*/ wire aba;
/*[.ABB]*/ wire abb;
/*[.ABC]*/ wire abc;

wire ba;
endmodule


//***************************************
module BB(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

wire bb;
/*[Previous]*/
reg p1_bb;
endmodule


//***************************************
module BC(
);


/*[.Sandbox]*/ wire clk;
/*[.Sandbox]*/ wire reset;

/*[.A]*/ wire a;
/*[.AB]*/ wire ab;
/*[.ABC]*/ wire abc;

wire bc;
endmodule