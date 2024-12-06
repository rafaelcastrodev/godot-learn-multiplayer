class_name PlayerStateMachine;
extends Node;

signal states_ready;

var current_state: PlayerState;
var current_state_name: String;
var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is PlayerState:
			states[child.name.to_lower()] = child;
			child.state_transitioned.connect(_on_state_transitioned);

	if current_state:
		current_state.enter();

	call_deferred( "_trigger_on_states_ready" );
#}


func _process(delta : float) -> void:
	if current_state:
		current_state.update(delta);
#}


func _physics_process(delta : float) -> void:
	if current_state:
		current_state.physics_update(delta);
#}


func _trigger_on_states_ready() -> void:
	states_ready.emit();
#}


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event);
#}


func force_state_transition(new_state_name: String, close_current_state: bool = false) -> void:
	var new_state : PlayerState = states.get(new_state_name.to_lower());
	
	if not new_state:
		printerr(
			"Cannot force state " + new_state_name + " transition. New state is empty or transition state name does
			not match a state's name"
			);
		return;

	if current_state and close_current_state:
		current_state.exit();
		new_state.is_active = false;
		current_state.is_active = false;
		current_state_name = '<null>';
	else:
		new_state.enter();
		new_state.is_active = true;
		current_state = new_state;
		current_state_name = new_state_name.to_lower();
#}


func _on_state_transitioned(source_state : PlayerState, new_state_name : String) -> void:
	# Source state has to be the current active state
	if source_state != current_state:
		printerr("Cannot change to " + new_state_name + " state state from source state");
		return;

	if not current_state:
		printerr("Current state is null, cannot transition");
		return;

	# Checking for the next state. If both are fine, the transition can be made.
	var new_state: PlayerState = states.get(new_state_name.to_lower());
	
	if not new_state:
		printerr("New state " + new_state_name + " is empty or transition state name does not match a state's name");

	if current_state:
		current_state.exit(); # Exit the old state
		new_state.is_active = false;
		current_state.is_active = false;

	current_state_name = new_state_name.to_lower();
	new_state.enter(); # Exit the new state
	new_state.is_active = true;
	current_state = new_state;
#}
