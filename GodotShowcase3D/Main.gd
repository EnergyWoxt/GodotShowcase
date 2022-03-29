extends Spatial

const SPAWNTIME = 3
const MINDIST = 15
const MAXDIST = 50

const ENEMY = preload("res://Entities/Enemies/Enemy.tscn")

var isometric_camera
var spawn_timer : Timer = Timer.new()

func _ready():
	isometric_camera = IsometricCamera.new(20)
	isometric_camera.set_target($Character)
	add_child(isometric_camera)
	
	$Character.connect("shoot", self, "_on_player_shoot")
	
	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.start(SPAWNTIME)

func _on_spawn_timer_timeout():
	randomize()
	for i in randi() % 6:
		var distance = rand_range(MINDIST, MAXDIST)
		var angle = rand_range(0, PI * 2)
		var enemy_spawn_point = Vector2(cos(angle), sin(angle)) * distance
		var enemy = ENEMY.instance()
		enemy.init(enemy_spawn_point)
		enemy.connect("characterKilled", self, "_on_character_killed")
		$Enemies.add_child(enemy)

func _on_player_shoot(projectile):
	add_child(projectile)

func _on_character_killed():
	isometric_camera.set_target(null)
	for enemy in $Enemies.get_children():
		enemy.target = null
