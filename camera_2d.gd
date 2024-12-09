class_name MultiTargetCamera2D
extends Camera2D

@export var move_speed = 0.5;
@export var zoom_speed = 0.05;
@export var min_zoom = 1.5;
@export var max_zoom = 10.0;
@export var margin = Vector2(400,200);

var targets = [];

@onready var screen_size = get_viewport_rect().size;

func _process(delta: float) -> void:
	if not targets:
		return;
	
	# Calculate the center point of all targets
	var center = Vector2.ZERO;
	for target in targets:
		center += target.global_position;
	center /= targets.size()
	
	# Smoothly move the camera towards the center point
	position = lerp(position, center, move_speed);
	
	# Calculate the bounding rectangle
	var bounding_rect = Rect2(center, Vector2.ZERO);
	for target in targets:
		bounding_rect = bounding_rect.expand(target.global_position);
	
	# Add margins to the bounding rectangle
	bounding_rect = bounding_rect.grow_individual(margin.x, margin.y, margin.x, margin.y);
	
	# Determine the zoom level
	var target_zoom = zoom;
	if bounding_rect.size.x > bounding_rect.size.y * screen_size.aspect():
		target_zoom = clamp(bounding_rect.size.x / screen_size.x, min_zoom, max_zoom);
	else:
		target_zoom = clamp(bounding_rect.size.y / screen_size.y, min_zoom, max_zoom);
	
	 # Smoothly adjust the zoom
	zoom = lerp(zoom, Vector2.ONE * target_zoom, zoom_speed);
	
	
#	}

func add_target(t) -> void:
	if not t in targets:
		targets.append(t);
#	}

func remove_target(t) -> void:
	if t in targets:
		targets.remove(t);
#	}

func _draw():
	if not targets:
		return;

	var bounding_rect = Rect2(position, Vector2.ZERO);
	for target in targets:
		bounding_rect = bounding_rect.expand(target.global_position);
	bounding_rect = bounding_rect.grow_individual(margin.x, margin.y, margin.x, margin.y);
	draw_rect(bounding_rect, Color.RED, false, 1);
#}
