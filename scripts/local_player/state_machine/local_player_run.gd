class_name LocalPlayerRun;
extends LocalPlayerState;

func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_current_speed = Globals.PLAYER_RUNNING_SPEED;
	owner.sfx_walk.stop();
	animator.play(Globals.PlayerAnimations.RUN);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if not owner.sfx_run.playing:
		owner.sfx_run.play();

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, Globals.PlayerAnimations.IDLE);
		return;
	
	if owner.is_character_walking:
		state_transitioned.emit(self, Globals.PlayerAnimations.WALK);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
