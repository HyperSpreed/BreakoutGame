extends CharacterBody2D

var speed = 10

func _physics_process(delta):
	var velocityPlayer = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocityPlayer.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocityPlayer.x += 1
	move_and_collide(velocityPlayer*speed)
