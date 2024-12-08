class_name LocalPlayer;
extends CharacterBody2D;

var player_id: int = 0;
var character_current_speed: float = 60.0;
var character_direction: Vector2;
var is_character_walking: bool = false;
var is_character_crouching: bool = false;
var is_character_attacking: bool = false;

@onready var camera: Camera2D = $Camera2D;
@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var character: CharacterBody2D = $".";
@onready var player_state_machine: Node = $PlayerStateMachine;
@onready var sfx_run: AudioStreamPlayer2D = $Sfx_Run;
@onready var sfx_walk: AudioStreamPlayer2D = $Sfx_Walk;
@onready var sfx_attack: AudioStreamPlayer2D = $Sfx_Attack;

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int());
#}

func _ready() -> void:
	player_state_machine.states_ready.connect(_on_state_machine_states_ready);
#}

func _physics_process(delta: float) -> void:

	character_direction = _get_character_direction_normalized();
	_handle_movement(delta);
#}

func _unhandled_input(event: InputEvent) -> void:
	
	is_character_walking = event.is_action_pressed(Globals.PlayerActions.WALK);
	#is_character_walking = MultiplayerInput.is_action_pressed(player_id, Globals.PlayerActions.WALK)
	
	#if MultiplayerInput.is_action_pressed(player_id, Globals.PlayerActions.ATTACK):
		#player_state_machine.force_state_transition(Globals.PlayerAnimations.ATTACK);
		#return;
				
	if event.is_action_pressed(Globals.PlayerActions.ATTACK):
		player_state_machine.force_state_transition(Globals.PlayerAnimations.ATTACK);
		return;
#}


func _handle_movement(delta: float) -> void:
	
	if is_character_attacking:
		velocity = Vector2.ZERO;
		return;
	
	if character_direction == Vector2.ZERO:
		sfx_run.stop();
		sfx_walk.stop();
		is_character_walking = false;
		return;	
	
	# MOVE character;
	if character_direction:
		velocity = character_direction * character_current_speed;
	else:
		velocity = velocity.move_toward(Vector2.ZERO, character_current_speed);

	# FLIP animator;
	if character_direction.x > 0:
		animator.flip_h = false;
	if character_direction.x < 0:
		animator.flip_h = true;
		
	move_and_slide();
#}


func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	player_state_machine.force_state_transition(Globals.PlayerAnimations.IDLE);
#}


func _connect_children_state_signals() -> void:

	for key in player_state_machine.states:
		var state = player_state_machine.states[key];
		if state is LocalPlayerState:
			state.animator = animator;
			state.collision = collision;
			state.character = character;
#}


func _get_character_direction_normalized():
	return Input.get_vector(Globals.PlayerActions.LEFT, Globals.PlayerActions.RIGHT, Globals.PlayerActions.UP, Globals.PlayerActions.DOWN).normalized();
	#return MultiplayerInput.get_vector(
		#player_id, 
		#Globals.PlayerActions.LEFT, 
		#Globals.PlayerActions.RIGHT, 
		#Globals.PlayerActions.UP, 
		#Globals.PlayerActions.DOWN).normalized();
##}
