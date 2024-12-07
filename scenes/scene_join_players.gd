extends Node2D

@onready var join_p_1_button: Button = $CanvasLayer/JoinP1Button
@onready var join_p_2_button: Button = $CanvasLayer/JoinP2Button
@onready var join_p_3_button: Button = $CanvasLayer/JoinP3Button
@onready var join_p_4_button: Button = $CanvasLayer/JoinP4Button
@onready var info_join_p_1: Label = $CanvasLayer/InfoJoinP1
@onready var info_join_p_2: Label = $CanvasLayer/InfoJoinP2
@onready var info_join_p_3: Label = $CanvasLayer/InfoJoinP3
@onready var info_join_p_4: Label = $CanvasLayer/InfoJoinP4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	join_p_1_button.pressed.connect(_on_pressed_button.bind('p1'))
	join_p_2_button.pressed.connect(_on_pressed_button.bind('p2'))
	join_p_3_button.pressed.connect(_on_pressed_button.bind('p3'))
	join_p_4_button.pressed.connect(_on_pressed_button.bind('p4'))
	
#	}

func _on_pressed_button(btn) -> void:
	print(btn)
#	}
