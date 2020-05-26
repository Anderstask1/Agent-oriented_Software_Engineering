:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add pickup(B) && (\+ belief has_box) => [

	cr goto(B),
	act pickup(B),
	add_belief(has_box),

	add_desire(deliver(B)),

	stop
].

add deliver(B) && (belief has_box) => [

	check_artifact_belief(B, first_half),
	
	act (getExchangeArea, ExchangeArea),
	cr goto(ExchangeArea),
	cr dropDown(ExchangeArea),
	del_belief(has_box),

	add_desire(call_sorting_bot(B)),

	stop
].

add deliver(B) && (belief has_box) => [

	check_artifact_belief(B, second_half),
	check_artifact_belief(B, startArea(S)),

	act (getArea(S), Area),

	cr goto(Area),
	cr dropDown(Area),
	del_belief(has_box),

	add_desire(call_drone(B)),

	stop
].

add call_sorting_bot(B) && (\+ belief has_box) => [
	act (getSortingBot, SortingBot),
	(
		not(check_agent_belief(SortingBot, busy)),
		add_agent_belief(SortingBot, busy)
	),
	add_agent_desire(SortingBot, pickup(B)),

	add_desire(return),

	stop
].

add call_drone(B) && true => [
	act (getDrone, Drone),

	(
		not(check_agent_belief(Drone, busy)),
		add_agent_belief(Drone, busy)
	),

	add_agent_desire(Drone, pickup(B)),

	add_desire(return),

	stop
].

add return && (\+ belief has_box) => [

	act (getChargingStation, Base),
	cr goto(Base),

	del_belief(busy),

	stop
].