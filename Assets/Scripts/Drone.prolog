:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add pickup(B) && (\+ belief has_box) => [

	B \= false,

	cr takeOff,
	cr goto(B),
	cr land,
	act pickup(B),

	add_belief(has_box),
	add_desire(deliver(B)),

	stop
].

add deliver(B) && (belief has_box) => [

	check_artifact_belief(B, first_half),
	check_artifact_belief(B, startArea(S)),
	check_artifact_belief(B, destinationArea(D)),
	
	act (getLandingZone(S, D), L),
	cr takeOff,
	cr goto(L),
	cr land,
	cr dropdown,
	del_belief(has_box),

	add_desire(call_rail_bot(B)),	

	stop
].

add deliver(B) && (belief has_box) => [

	check_artifact_belief(B, second_half),
	check_artifact_belief(B, startArea(S)),
	check_artifact_belief(B, destinationArea(D)),
	
	act (getLandingZone(D, S), L),
	cr takeOff,
	cr goto(L),
	cr land,
	cr dropdown,
	del_belief(has_box),

	add_desire(call_pickup_area(B)),	

	stop
].

add call_rail_bot(B) && (\+ belief has_box) => [

	check_artifact_belief(B, startArea(S)),

	act (getRailBot(S), RailBot),
	(
		not(check_agent_belief(RailBot, busy)),
		add_agent_belief(RailBot, busy)
	),
	add_agent_desire(RailBot, pickup(B)),

	add_desire(return),

	stop
].

add call_pickup_area(B) && (\+ belief has_box) => [

	check_artifact_belief(B, destinationArea(D)),

	add_agent_desire(D, recall_box(B)),

	add_desire(return),

	stop
].


add return && (\+ belief has_box) => [

	act (getChargingStation, Base),
	cr takeOff,
	cr goto(Base),
	cr land,

	del_belief(busy),

	stop
].