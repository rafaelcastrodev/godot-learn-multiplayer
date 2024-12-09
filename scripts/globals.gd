extends Node;

#Error if not 'var'
var GRAVITY: int = ProjectSettings.get_setting("physics/2d/default_gravity");

const PLAYER_RUNNING_SPEED: float = 120.0;
const PLAYER_WALKING_SPEED: float = 60.0;
const PLAYER_CROUCHING_SPEED: float = 30.0;
const PLAYER_JUMP_SPEED: float = 300.0;
const MAX_PLAYERS: int = 4;

const PlayerActions: Dictionary = {
	START = "start",
	SWAP_SKIN = "swap_skin",
	JOIN = "join",
	UP = "move_up",
	LEFT = "move_left",
	DOWN = "move_down",
	RIGHT = "move_right",
	JUMP = "jump",
	WALK = "walk",
	CROUCH = "crouch",
	ATTACK = "attack",
};

const PlayerAnimations: Dictionary = {
	IDLE = "idle",
	WALK = "walk",
	JUMP = "jump",
	RUN = "run",
	CROUCH = "crouch",
	ATTACK = "attack",
	HURT = "hurt",
};

const PlayerSkins: Dictionary = {
	DINO_BLUE = preload("res://assets/sprites/dinos/dino_blue.tres"),
	DINO_RED = preload("res://assets/sprites/dinos/dino_red.tres"),
	DINO_YELLOW = preload("res://assets/sprites/dinos/dino_yellow.tres"),
	DINO_GREEN = preload("res://assets/sprites/dinos/dino_green.tres"),
	DINO_PINK = preload("res://assets/sprites/dinos/dino_pink.tres"),
};
