extends Camera

class_name IsometricCamera

const ROTSPD = 90
const OFFSETSPD = 40

var target : Spatial
var zOffset = 0

func _init(height : float):
	current = true
	#translate(Vector3(0, height, 0))
	translation.y = height
	rotation_degrees.x = -80

func _process(delta):
	if target != null:
		translation.x = target.translation.x
		translation.z = target.translation.z + zOffset
	if Input.is_action_pressed("ROTCAM+"):
		rotation_degrees.x += ROTSPD * delta
		zOffset += OFFSETSPD * delta
	if Input.is_action_pressed("ROTCAM-"):
		rotation_degrees.x -= ROTSPD * delta
		zOffset -= OFFSETSPD * delta

func set_target(target : Spatial):
	self.target = target
