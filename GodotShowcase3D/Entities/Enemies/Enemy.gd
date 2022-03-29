extends KinematicBody

class_name Enemy

signal characterKilled()

const SPEED = 6

var target

func init(position : Vector2):
	translation.x = position.x
	translation.z = position.y

func _on_Area_body_entered(body : Spatial):
	if body.name == "Character":
		target = body

func _process(delta):
	if (target != null):
		var direction = (target.translation - translation).normalized()
		var collision = move_and_collide(direction * SPEED * delta)
		if collision != null and collision.collider.name == "Character":
			collision.collider.queue_free()
			emit_signal("characterKilled")
