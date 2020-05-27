:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add pickup(B) && (\+ belief has_box) => [

	cr goto(B),
	act pickup(B),
	add_belief(has_box),

	add_desire(deliver(B)),

	stop
].

add deliver(B) && (belief has_box) => [

	check_artifact_belief(B, destinationArea(D)),
	act (getExchangeArea(D), ExchangeArea),

	cr goto(ExchangeArea),
	cr dropDown(ExchangeArea),
	del_belief(has_box),
	
	del_artifact_belief(B, first_half),
	add_artifact_belief(B, second_half),

	add_desire(call_rail_bot(B)),

	stop
].

add call_rail_bot(B) && (\+ belief has_box) => [

	check_artifact_belief(B, destinationArea(D)),

	act (getRailBot(D), RailBot),
	(
		not(check_agent_belief(RailBot, isBusy)),
		add_agent_belief(RailBot, isBusy)
	),
	add_agent_desire(RailBot, pickup(B)),

	add_desire(return),
	
	stop
].

add return && (\+ belief has_box) => [

	del_belief(isBusy),

	act (getChargingStation, Base),
	cr goto(Base),

	stop
].