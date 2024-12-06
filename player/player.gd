extends CharacterBody2D;

const PlayerActions: Dictionary = {
	UP = "move_up",
	LEFT = "move_left",
	DOWN = "move_down",
	RIGHT = "move_right",
	JUMP = "jump",
	RUN = "run",
	CROUCH = "crouch",
	ATTACK = "attack",
};

const PlayerAnimations: Dictionary = {
	IDLE = "idle",
	WALK = "walk",
	JUMP = "jump",
	RUN = "run",
	CROUCH = "crouch",
	ATTACK = "attack",
	HURT = "hurt",
};

@export var character_speed = 60.0;
@export var jump_velocity = 300.0;

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity");
var character_direction: Vector2;
var is_character_running: bool = false;
var is_character_crouching: bool = false;

@onready var collision: CollisionShape2D = $CollisionShape2D;
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D;
@onready var character: CharacterBody2D = $".";
@onready var player_state_machine: Node = $PlayerStateMachine;

func _ready() -> void:
	player_state_machine.states_ready.connect(_on_state_machine_states_ready);
#}


func _physics_process(delta: float) -> void:
	character_direction = _get_character_direction_normalized();
	_handle_movement(delta);
#}


func _handle_movement(delta: float) -> void:

	if character_direction == Vector2.ZERO:
		is_character_running = false;
		return;
	is_character_running = Input.is_action_pressed("run");

	# MOVE character;
	if character_direction:
		velocity = character_direction * character_speed;
	else:
		velocity = velocity.move_toward(Vector2.ZERO, character_speed);

	# FLIP animator;
	if character_direction.x > 0:
		animator.flip_h = false;
	else:
		animator.flip_h = true;

	move_and_slide();
#}


func _on_state_machine_states_ready() -> void:
	_connect_children_state_signals();
	player_state_machine.force_state_transition("idle");
#}


func _connect_children_state_signals() -> void:
	for key in player_state_machine.states:
		var state = player_state_machine.states[key];
		if state is PlayerState:
			state.animator = animator;
			state.collision = collision;
			state.character = character;
#}


func _get_character_direction_normalized():
	return Input.get_vector(PlayerActions.LEFT, PlayerActions.RIGHT, PlayerActions.UP, PlayerActions.DOWN).normalized();
#}
