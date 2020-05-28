:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add pickup(B) && (\+ belief delivered(B)) => [

	B \= false,

	check_artifact_belief(B, startArea(S)),
	check_artifact_belief(B, destinationArea(D)),

	cr takeOff,
	cr goto(B),
	cr land,
	act pickup(B),

	act (getLandingZone(S, D), L),

	cr takeOff,
	cr goto(L),
	cr land,
	cr dropdown,

	act (getRailBot(S), RailBot),
	add_desire(call(RailBot, B)),

	add_belief(delivered(B)),
	add_desire(return),

	stop
].

add deliver(B) && (\+ belief delivered(B)) => [

	B \= false,

	check_artifact_belief(B, destination(D)),

	cr takeOff,
	cr goto(B),
	cr land,
	act pickup(B),

	cr takeOff,
	cr goto(D),
	cr land,
	cr dropdown,
	
	add_agent_desire(D, recall_box(B)),

	add_belief(delivered(B)),

	act (getChargingStation, Base),
	cr takeOff,
	cr goto(Base),
	cr land,

	stop
].

add call(RailBot, B) && true => [
	
	(
        not(check_agent_belief(RailBot, isBusy)),
        add_agent_belief(RailBot, isBusy)
	),

	add_agent_desire(RailBot, pickup(B)),

	stop
].

add return && true => [

	act (getChargingStation, Base),
	cr takeOff,
	cr goto(Base),
	cr land,

	del_belief(isBusy),

	stop
].