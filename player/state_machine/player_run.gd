class_name PlayerRun;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_current_speed = owner.character_running_speed;
	animator.play(owner.PlayerAnimations.RUN);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if not owner.sfx_run.playing:
		owner.sfx_walk.stop();
		owner.sfx_run.play();

	if owner.is_character_running:
		return;

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, owner.PlayerAnimations.IDLE);
		return;

	state_transitioned.emit(self, owner.PlayerAnimations.WALK);
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
