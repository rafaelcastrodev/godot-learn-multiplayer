class_name OnlinePlayerRun;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_current_speed = owner.character_running_speed;
	owner.sfx_walk.stop();
	animator.play(owner.PlayerAnimations.RUN);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if not owner.sfx_run.playing:
		owner.sfx_run.play();

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, owner.PlayerAnimations.IDLE);
		return;
	
	if owner.is_character_walking:
		state_transitioned.emit(self, owner.PlayerAnimations.WALK);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
