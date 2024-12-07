class_name LocalPlayerIdle;
extends LocalPlayerState;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.velocity = Vector2.ZERO;
	animator.play(Globals.PlayerAnimations.IDLE);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if owner.character_direction == Vector2.ZERO:
		return;

	if owner.is_character_walking:
		state_transitioned.emit(self, Globals.PlayerAnimations.WALK);
		return;

	state_transitioned.emit(self, Globals.PlayerAnimations.RUN);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
