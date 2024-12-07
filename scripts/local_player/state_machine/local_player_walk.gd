class_name LocalPlayerWalk;
extends LocalPlayerState;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_current_speed = Globals.PLAYER_WALKING_SPEED;
	owner.sfx_run.stop();
	animator.play(Globals.PlayerAnimations.WALK);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if not owner.sfx_walk.playing:
		owner.sfx_walk.play();
	
	if owner.is_character_walking:
		return;

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, Globals.PlayerAnimations.IDLE);
		return;

	state_transitioned.emit(self, Globals.PlayerAnimations.RUN);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
