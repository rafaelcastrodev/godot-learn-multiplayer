class_name LocalPlayerAttack;
extends LocalPlayerState;

func _ready() -> void:
	super();
#}

func on_animation_finished() -> void:
	super();
	state_transitioned.emit(self, Globals.PlayerAnimations.IDLE);
	owner.is_character_attacking = false;
#}


func enter() -> void:
	super();
	owner.sfx_run.stop();
	owner.sfx_walk.stop();
	owner.sfx_attack.play();
	owner.is_character_attacking = true;
	animator.play(Globals.PlayerAnimations.ATTACK);
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
