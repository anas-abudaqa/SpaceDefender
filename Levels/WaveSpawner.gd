extends Node2D

class_name EnemySpawner

signal WaveStarted
signal WaveEnded

var enemies_in_wave: int = 0
var enemies_in_wave_left: int = 0
#Player
@export var camera: Camera2D
#Enemy type to spawn:
var enemy1_scene = preload("res://Characters/Enemy1/Enemy1.tscn")


#func load_scene(enemy: CharacterBody2D ,path: String):
	#enemy = load(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func wave_start():
	WaveStarted.emit()
	print("Wave Spawner: Let's start")
	spawn_line()

func get_starting_point() -> Vector2:
	#returns all the way to the right, middle of the screen
	return camera.global_position + Vector2(640, 0)

func spawn_line():
	enemies_in_wave = 5
	enemies_in_wave_left = enemies_in_wave
	var starting_position = get_starting_point()
	#800/2, or take 700 to give some bot and top margins
	var y_offset = -350
	for instance in enemies_in_wave:
		var enemy = enemy1_scene.instantiate()
		get_tree().root.add_child(enemy)
		enemy.spawn(starting_position + Vector2(0, y_offset))
		enemy.connect("EnemyDied", on_enemy_death)
		print("Wave Spawner: I have spawned an enemy: ", enemy)
		y_offset += 175



func on_enemy_death():
	enemies_in_wave_left -= 1
	if enemies_in_wave_left == 0:
		WaveEnded.emit()
		print("Wave Spawner: We ending the wave now")

func _on_level_1_start_enemy_1_wave():
	wave_start()
