extends CharacterBody2D

var BallSpeed = 400
var VelocityBall = Vector2.ZERO

func _ready():
	get_node("/root/Main/TimerLabel").text = "STARTING IN 3..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabel").text = "STARTING IN 2..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabel").text = "STARTING IN 1..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabel").text = ""
	randomize()
	VelocityBall.x = [0.45,0.5][randi()%2]
	VelocityBall.y = [0.8,0.9][randi()%2]

func _physics_process(delta):
	var collision_objects = move_and_collide(VelocityBall*BallSpeed*delta)
	if collision_objects:
		var collider = collision_objects.get_collider()
		if collider.is_in_group("Walls"):
			VelocityBall = VelocityBall.bounce(collision_objects.get_normal())
			
		elif collider.is_in_group("Paddle"):
			var collision_point = collision_objects.get_position()
			var paddle_position = collider.position
			var paddle_width = (collider as Node).get_node("CollisionShape2D").shape.extents.x * 2
			var ball_direction = (collision_point.x - paddle_position.x) / (paddle_width / 2)
			VelocityBall.x = ball_direction * 1
			VelocityBall.y = -abs(VelocityBall.y)
			VelocityBall = VelocityBall.normalized()
			
		elif collider.is_in_group("Bricks"):
			collider._on_CollisionShape2D_body_entered(self)
			VelocityBall = VelocityBall.bounce(collision_objects.get_normal())
			BallSpeed += 5
			print("HIT!")
			
