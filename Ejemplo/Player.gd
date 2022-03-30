extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 100)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direccion = Vector2.ZERO
	if Input.is_action_pressed("ARRIBA"):
		direccion.y += -1
	if Input.is_action_pressed("ABAJO"):
		direccion.y += 1
	if Input.is_action_pressed("DERECHA"):
		direccion.x += 1
	if Input.is_action_pressed("IZQUIERDA"):
		direccion.x += -1
	var movimiento = direccion * 400
	move_and_slide(movimiento)
