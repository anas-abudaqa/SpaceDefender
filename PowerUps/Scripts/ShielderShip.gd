extends CharacterBody2D

const SPEED = 2.0
const ROTATION_RADIUS = 120
var angle:float = 0.0

func _ready():
	global_position = get_spawn_coordinates()
	
func get_spawn_coordinates() -> Vector2:
	return get_parent().global_position
	
func _physics_process(delta):
	angle += SPEED * delta
	var x_pos = cos(angle)
	var y_pos = sin(angle)
	
	position.x = ROTATION_RADIUS * x_pos
	position.y = ROTATION_RADIUS * y_pos

