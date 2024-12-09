class_name LocalPlayer;
extends CharacterBody2D;

signal leave;

var player_id: int = 0;
var player_device: int = 0;
var character_current_speed: float = 60.0;
var character_direction: Vector2;
var character_current_skin: int = 0;
var is_character_walking: bool = false;
var is_character_crouching: bool = false;
var is_character_attacking: bool = false;

#@onready var camera: Camera2D = $Camera2D;
@onready var player_state_machine: Node = $PlayerStateMachine;
@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var character: CharacterBody2D = $".";
@onready var sfx_run: AudioStreamPlayer2D = $Sfx_Run;
@onready var sfx_walk: AudioStreamPlayer2D = $Sfx_Walk;
@onready var sfx_attack: AudioStreamPlayer2D = $Sfx_Attack;
@onready var label: Label = $Label;


func init(id: int):
	player_id = id;
	player_device = PlayerManager.get_player_device(player_id);
#}

func _ready() -> void:
	player_state_machine.states_ready.connect(_on_state_machine_states_ready);
	animator.animation_finished.connect(_on_animation_finished);
#}

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int());
#}

func _physics_process(delta: float) -> void:

	character_direction = _get_character_direction_normalized();
	_handle_movement(delta);
#}

func _unhandled_input(event: InputEvent) -> void:
	
	is_character_walking = MultiplayerInput.is_action_pressed(player_device, Globals.PlayerActions.WALK)
	
	if MultiplayerInput.is_action_pressed(player_device, Globals.PlayerActions.SWAP_SKIN):
		_change_character_skin();
	
	if not is_character_attacking and MultiplayerInput.is_action_pressed(player_device, Globals.PlayerActions.ATTACK):
		player_state_machine.current_state.state_transitioned.emit(player_state_machine.current_state, Globals.PlayerAnimations.ATTACK);
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


func _connect_children_state_signals() -> void:

	for key in player_state_machine.states:
		var state = player_state_machine.states[key];
		if state is LocalPlayerState:
			state.animator = animator;
			state.collision = collision;
			state.character = character;
#}

func _get_character_direction_normalized():
	
	return MultiplayerInput.get_vector(
		player_device,
		Globals.PlayerActions.LEFT, 
		Globals.PlayerActions.RIGHT, 
		Globals.PlayerActions.UP, 
		Globals.PlayerActions.DOWN).normalized();
#}

func _change_character_skin() -> void:
	if character_current_skin == 4:
		character_current_skin = 0;
	else:
		character_current_skin += 1;

	match character_current_skin:
		0: animator.set_sprite_frames(Globals.PlayerSkins.DINO_RED);
		1: animator.set_sprite_frames(Globals.PlayerSkins.DINO_BLUE);
		2: animator.set_sprite_frames(Globals.PlayerSkins.DINO_YELLOW);
		3: animator.set_sprite_frames(Globals.PlayerSkins.DINO_GREEN);
		4: animator.set_sprite_frames(Globals.PlayerSkins.DINO_PINK);
	var current_animation = animator.animation;
	animator.play(current_animation);
	
#}

func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	player_state_machine.force_state_transition(Globals.PlayerAnimations.IDLE);
#}

func _on_animation_finished():
	player_state_machine.current_state.on_animation_finished();
#	}
