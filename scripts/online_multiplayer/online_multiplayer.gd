extends Node2D

@export var player_scene: PackedScene;

var _peer = ENetMultiplayerPeer.new();
var _server_port: int = 1027;
var max_players: int = 4;

@onready var canvas_layer: CanvasLayer = $CanvasLayer;
@onready var host_button: Button = $CanvasLayer/HostButton
@onready var join_button: Button = $CanvasLayer/JoinButton


func _ready() -> void:
	host_button.pressed.connect(_on_host_pressed);
	join_button.pressed.connect(_on_join_pressed);
#}

func _on_join_pressed() -> void:
	_peer.create_client("localhost", _server_port);
	multiplayer.multiplayer_peer = _peer;
	_hide_ui();
#}

func _on_host_pressed() -> void:
	_peer.create_server(_server_port);
	multiplayer.multiplayer_peer = _peer;
	multiplayer.peer_connected.connect(_on_peer_connected);
	_add_player()
	_hide_ui();
#}

func _on_peer_connected(id: int) -> void:
	_add_player(id);
#}

func _add_player(id = 1) -> void:
	var player = player_scene.instantiate();
	player.name = str(id);
	call_deferred("add_child", player);
#}

func exit_game(id: int) -> void:
	##Deletes player throughout clients	
	multiplayer.peer_disconnected.connect(remove_player);
	##Deletes player locally
	remove_player(id);
#}

func remove_player(id: int) -> void:
	rpc("_rpc_remove_player", id);
#}

@rpc("any_peer", "call_local")
func _rpc_remove_player(id: int) -> void:
	get_node(str(id)).queue_free();
#}

func _hide_ui() -> void:
	canvas_layer.hide();
#}
