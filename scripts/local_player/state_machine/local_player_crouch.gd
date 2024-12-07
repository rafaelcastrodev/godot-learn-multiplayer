class_name LocalPlayerCrouch;
extends LocalPlayerState;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_speed = Globals.PLAYER_CROUCHING_SPEED;
	animator.play(Globals.PlayerAnimations.CROUCH);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:
	return;
	if owner.is_character_crouching:
		return;

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, Globals.PlayerAnimations.IDLE);
		return;

	state_transitioned.emit(self, Globals.PlayerAnimations.WALK);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
