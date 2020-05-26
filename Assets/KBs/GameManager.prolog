:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

desire generateBoxes.

add generateBoxes && true => [

	add_desire(createBox(7,0)),
	add_desire(createBox(3,0)),

	add_desire(wait(15)),
	
	add_desire(createBox(7,8)),
	add_desire(createBox(3,2)),

	stop
].

add createBox(StartIndex, DestIndex) && true => [

	act (getArea(StartIndex), S),
	act (getArea(DestIndex), D),
	act (spawnBox(S, D), B),

	add_artifact_belief(B, start(S)),
	add_artifact_belief(B, destination(D)),

	check_agent_belief(S, area(StartArea)),
	add_artifact_belief(B, startArea(StartArea)),

	check_agent_belief(D, area(DestinationArea)),
	add_artifact_belief(B, destinationArea(DestinationArea)),

	add_artifact_belief(B, first_half),

	add_agent_desire(S, call_drone(B)),

	stop
].

add wait(Seconds) && true => [

	cr waitForSeconds(Seconds),

	stop
].