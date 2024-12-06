class_name PlayerAttack;
extends PlayerState;


func _ready() -> void:
	super();
#}

func finish_attack():
	state_transitioned.emit(self, owner.PlayerAnimations.IDLE);
#}

func enter() -> void:
	super();
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
