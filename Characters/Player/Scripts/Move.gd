extends State


## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func state_process(delta):
	#character.direction_vector.x = Input.get_axis("Left", "Right")
	#character.direction_vector.y = Input.get_axis("Up", "Down")
#
	#if character.direction_vector.x == +1:
		#character.velocity.x = character.direction_vector.x * character.FORWARD_SPEED
		##$AnimationPlayer.play("Move")
	#elif character.direction_vector.x == -1:
		#character.velocity.x = character.direction_vector.x * character.BACKWARD_SPEED
	#else:
		#character.velocity.x = move_toward(character.velocity.x, character.CRUISE_SPEED, character.DECELERATION)
		#
	#if character.direction_vector.y == +1:
		#character.velocity.y = character.direction_vector.y * character.VERTICAL_SPEED
		##$AnimationPlayer.play("Down")
	#elif character.direction_vector.y == -1:
		#character.velocity.y = character.direction_vector.y * character.VERTICAL_SPEED
		##$AnimationPlayer.play("Up")
	#else:
		#character.velocity.y = move_toward(character.velocity.y, 0, character.DECELERATION)
		##$AnimationPlayer.play("Move")
