class_name OnlinePlayerWalk;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_current_speed = owner.character_walk_speed;
	owner.sfx_run.stop();
	animator.play(owner.PlayerAnimations.WALK);
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
		state_transitioned.emit(self, owner.PlayerAnimations.IDLE);
		return;

	state_transitioned.emit(self, owner.PlayerAnimations.RUN);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
