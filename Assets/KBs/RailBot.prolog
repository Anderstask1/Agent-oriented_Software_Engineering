:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add pickup(B) && (\+ belief delivered(B))  => [

	B \= false,

	cr goto(B),
	act pickup(B),

	act (getExchangeArea, ExchangeArea),
	cr goto(ExchangeArea),

	act (getSortingBot, SortingBot),

	cr dropDown(ExchangeArea),

	add_agent_desire(SortingBot, pickup(B)),

	add_belief(delivered(B)),

	act (getChargingStation, Base),
	cr goto(Base),

	del_belief(isBusy),

	stop
].


add deliver(B) && (\+ belief delivered(B))  => [

	B \= false,

	check_artifact_belief(B, startArea(S)),

	cr goto(B),
	act pickup(B),

	act (getArea(S), Area),
	cr goto(Area),

	act (getDrone, Drone),
	(
        not(check_agent_belief(Drone, isBusy)),
        add_agent_belief(Drone, isBusy)
	),

	cr dropDown(Area),

	add_agent_desire(Drone, deliver(B)),

	add_belief(delivered(B)),

	act (getChargingStation, Base),
	cr goto(Base),

	del_belief(isBusy),

	stop
].