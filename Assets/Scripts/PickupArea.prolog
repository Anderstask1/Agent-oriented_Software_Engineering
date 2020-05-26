:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add call_drone(B) && true => [

	act (getDrone, Drone),

	(
		not(check_agent_belief(Drone, busy)),
		add_agent_belief(Drone, busy)
	),

	add_agent_desire(Drone, pickup(B)),

	stop
].

add recall_box(B) && true => [

	act destroy(B),

	stop
].