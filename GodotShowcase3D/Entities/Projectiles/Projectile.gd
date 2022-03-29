extends KinematicBody

class_name Projectile

const SPEED = 40

var direction : Vector2

func init(origin : Vector3, direction : Vector2):
	translation = origin
	self.direction = direction

func _process(delta):
	var collision : KinematicCollision = move_and_collide(Vector3(direction.x * SPEED, 0, direction.y * SPEED) * delta)
	if collision != null:
		if collision.collider is Enemy:
			collision.collider.queue_free()
			queue_free()
