:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add pickup(B) && (\+ belief delivered(B)) => [

	B \= false,

	check_artifact_belief(B, destinationArea(D)),

	cr goto(B),
	act pickup(B),

	act (getExchangeArea(D), ExchangeArea),
	cr goto(ExchangeArea),

	act (getRailBot(D), RailBot),
	(
        not(check_agent_belief(RailBot, isBusy)),
        add_agent_belief(RailBot, isBusy)
	),

	cr dropDown(ExchangeArea),

	add_agent_desire(RailBot, deliver(B)),

	add_belief(delivered(B)),

	act (getChargingStation, Base),
	cr goto(Base),

	stop
].