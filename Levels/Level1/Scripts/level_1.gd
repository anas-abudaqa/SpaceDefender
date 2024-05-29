extends Node2D

signal StartEnemy1Wave
signal StartSpikyRockWave
signal StartPowerUpSpawner
var waves_left: int = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	#for powerup_path in AllKnowing.current_powerups:
		#var powerup = load(powerup_path)
		#$player.add_child(powerup)
	
	$ObstacleWaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_obstacle_wave_timer_timeout():
	StartSpikyRockWave.emit()


func _on_enemy_wave_timer_timeout():
	StartEnemy1Wave.emit()


func _on_enemy_spawner_wave_ended():
	$PowerUpTimer.start()
	


func _on_obstacle_spawner_wave_ended():
	$EnemyWaveTimer.start()


func _on_power_up_timer_timeout():
	StartPowerUpSpawner.emit()


func _on_power_up_spawner_wave_ended():
	#$PowerUpTimer.start()
	$ObstacleWaveTimer.start()
