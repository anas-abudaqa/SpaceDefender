extends StaticBody2D

signal RockGone

# Called when the node enters the scene tree for the first time.
func _ready():
	$ExpiryTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn(spawn_coordinates: Vector2):
	global_position = spawn_coordinates

func _on_expiry_timer_timeout():
	queue_free()
	RockGone.emit()
