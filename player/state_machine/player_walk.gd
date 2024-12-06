class_name PlayerWalk;
extends PlayerState;


func _ready() -> void:
	super();
#}


func enter() -> void:
	super();
	owner.character_speed = 60.0;
	animator.play(owner.PlayerAnimations.WALK);
#}


func exit() -> void:
	super();
#}


# Updates every _process() update (When state is_active)
func update(delta: float) -> void:

	if owner.character_direction == Vector2.ZERO:
		state_transitioned.emit(self, owner.PlayerAnimations.IDLE);
		return;

	if owner.is_character_running:
		state_transitioned.emit(self, owner.PlayerAnimations.RUN);
		return;
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
