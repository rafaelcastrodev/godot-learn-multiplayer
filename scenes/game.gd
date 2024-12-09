extends Node2D

var player_nodes = {};
const PLAYER_SCENE: PackedScene = preload("res://scripts/local_player/local_player.tscn");
@onready var multi_target_camera_2d: Camera2D = $MultiTargetCamera2D;

func _ready() -> void:
	PlayerManager.player_joined.connect(spawn_player);
	PlayerManager.player_left.connect(delete_player);
#	}

func _process(_delta):
	PlayerManager.handle_join_input();
#	}

func spawn_player(player_id: int):
	# create the player node
	var player_node = PLAYER_SCENE.instantiate();
	player_node.leave.connect(_on_player_leave);
	player_nodes[player_id] = player_node;
	
	# let the player know which device controls it
	var device = PlayerManager.get_player_device(player_id);
	player_node.init(player_id);
	
	# add the player to the tree
	add_child(player_node);
	player_node.position = Vector2(randf_range(0, 40), randf_range(0, 40));
	multi_target_camera_2d.add_target(player_node);
#	}

func delete_player(player: int):
	multi_target_camera_2d.remove_target(player_nodes[player]);
	player_nodes[player].queue_free()
	player_nodes.erase(player);
#	}

func _on_player_leave(player: int):
	PlayerManager.leave(player);
