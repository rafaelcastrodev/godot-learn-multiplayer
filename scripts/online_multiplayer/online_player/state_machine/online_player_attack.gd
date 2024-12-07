class_name OnlinePlayerAttack;
extends PlayerState;


func _ready() -> void:
	super();
#}

func finish_attack():
	state_transitioned.emit(self, owner.PlayerAnimations.IDLE);
	owner.is_character_attacking = false;
#}

func enter() -> void:
	super();
	owner.sfx_run.stop();
	owner.sfx_walk.stop();
	owner.sfx_attack.play();
	owner.is_character_attacking = true;
	animator.animation_finished.connect(finish_attack);
	animator.play(owner.PlayerAnimations.ATTACK);
#}


func exit() -> void:
	super();
#}

# Updates every _process() update (When state is_active)
func update(delta: float) -> void:
	pass
#}


# Updates every _physics_process() update (When state is_active)
func physics_update(delta: float) -> void:
	pass;
#}
