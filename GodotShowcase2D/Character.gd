extends KinematicBody2D

const MAX_WALKSPEED = 500
const MAX_AIRSPEED = 400
const JUMPACCELERATION = -1500
const GRAVITY = 3000
const WALKACCELERATION = 1000
const AIRACCELERATION = 800

enum STATE {
	IDLE
	WALKING
	JUMPING
}

var state
var velocity : Vector2 = Vector2.ZERO
var flip : int = -1

func _ready():
	state = STATE.IDLE
	
func _process(delta):
	if state != STATE.JUMPING:
		velocity.y = 0
		if Input.is_action_pressed("JUMP"):
			velocity.y = JUMPACCELERATION
			state = STATE.JUMPING
		
		
	if STATE.JUMPING and is_on_floor():
		if velocity.x != 0:
			state = STATE.WALKING
		else:
			state = STATE.IDLE
	
	
	if !is_on_floor() and state != STATE.JUMPING:
		state = STATE.JUMPING
		velocity.y = 0
	
	if state != STATE.JUMPING:
		if Input.is_action_pressed("LEFT") or Input.is_action_pressed("RIGHT"):
			state = STATE.WALKING
		else:
			state = STATE.IDLE
	
	print(STATE.values()[state])
	
	match state:
		STATE.IDLE:
			velocity.x *= pow(0.01, 2*delta)
			$AnimationPlayer.play("IDLE")

		STATE.WALKING:
			var direction = Vector2.ZERO
			if Input.is_action_pressed("RIGHT"):
				direction.x += 1
			if Input.is_action_pressed("LEFT"):
				direction.x -= 1
			var walkacceleration = direction * WALKACCELERATION * delta
			velocity += walkacceleration
			if abs(velocity.x) > MAX_WALKSPEED:
				velocity.x = sign(velocity.x) * MAX_WALKSPEED
			$AnimationPlayer.play("WALK")

		STATE.JUMPING:
			var direction = Vector2.ZERO
			if Input.is_action_pressed("RIGHT"):
				direction.x += 1
			if Input.is_action_pressed("LEFT"):
				direction.x -= 1
			if direction.x == 0:
				velocity.x *= pow(0.01, delta)
			else:
				var airacceleration = direction * AIRACCELERATION * delta
				velocity += airacceleration
			if abs(velocity.x) > MAX_AIRSPEED:
				velocity.x = sign(velocity.x) * MAX_AIRSPEED
			
			if velocity.y < 0:
				$AnimationPlayer.play("JUMPUP")
			if velocity.y > 0:
				$AnimationPlayer.play("JUMPDOWN")
			if abs(velocity.y) < 200:
				$AnimationPlayer.stop()
				$AnimationPlayer.play("JUMPMID")
			
	
	if sign(velocity.x) != flip and velocity.x != 0:
		flip = sign(velocity.x)
		$Sprite.flip_h = !$Sprite.flip_h
	
	velocity.y += GRAVITY * delta
	move_and_slide(velocity, Vector2.UP)

