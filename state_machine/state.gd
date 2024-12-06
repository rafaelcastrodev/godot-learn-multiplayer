class_name State;
extends Node;
"""
Base State class for the Finite State Machine
"""
signal state_transitioned(source_state: State, new_state_name: String);

var character: CharacterBody2D;
var is_active: bool = false;

func _ready() -> void:
	set_physics_process(false);
#}


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent) -> void:
	pass;


func enter() -> void:
	set_physics_process(true);
	#print("Enter State: ", self);
#}


func exit() -> void:
	set_physics_process(false);
#}


func update(delta: float) -> void:
	pass;
#}


func physics_update(delta: float) -> void:
	pass;
#}
