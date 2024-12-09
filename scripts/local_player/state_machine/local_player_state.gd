class_name LocalPlayerState;
extends Node;

"""
Base State class for the Finite State Machine
"""
signal state_transitioned(source_state: LocalPlayerState, new_state_name: String);
signal state_animated(animation_name: String);

var character: CharacterBody2D;
var animator: AnimatedSprite2D;
var collision: CollisionShape2D;
var is_active: bool = false;

func _ready() -> void:
	set_physics_process(false);
#}


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent) -> void:
	pass;


func enter() -> void:
	print("State: ", owner.player_state_machine.current_state_name);
	set_physics_process(true);
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

func on_animation_finished() -> void:
	pass;
#}
