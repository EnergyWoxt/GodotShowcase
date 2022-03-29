extends KinematicBody

class_name Character

signal shoot(projectile)

const projectile = preload("res://Entities/Projectiles/Projectile.tscn")

const SPEED = 10
const CHARRADIUS = 1
const CHARHEIGHT = 2

func _process(delta):
	var direction = Vector3.ZERO
	if Input.is_action_pressed("UP"):
		direction.z -= 1
	if Input.is_action_pressed("DOWN"):
		direction.z += 1
	if Input.is_action_pressed("RIGHT"):
		direction.x += 1
	if Input.is_action_pressed("LEFT"):
		direction.x -= 1
	var velocity = direction.normalized() * SPEED
	move_and_slide(velocity)
	
	if Input.is_action_just_pressed("SHOOT"):
		var newProjectile = projectile.instance()
		var mouseDirection = (get_viewport().get_mouse_position() - get_viewport().size/2).normalized()
		var origin = translation + Vector3(0, CHARHEIGHT/2, 0) + CHARRADIUS * Vector3(mouseDirection.x, 0, mouseDirection.y)
		newProjectile.init(origin, mouseDirection)
		emit_signal("shoot", newProjectile)
