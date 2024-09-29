extends CharacterBody2D

var BallSpeed = 400
var VelocityBall = Vector2.ZERO

func gameOverNow():
	var isGameOver = 0
	var gameoverFromMain = get_node("/root/Main")
	var gameState = gameoverFromMain.gameOverNow
	print(gameState)
	return gameState

func _ready():
		if gameOverNow() == true:
			var resetGame = get_node("/root/Main")
			resetGame.game_over()
		else:
			var timer_label = get_node("/root/Main/TimerLabel")
			timer_label.add_theme_font_size_override("font_size", 12)
			#get_node("/root/Main/TimerLabel").text = "STARTING"
			#get_node("/root/Main/TimerLabel").text = ""
			#timer_label.text = "STARTING"
			#timer_label.text = ""
			await get_tree().create_timer(3).timeout
			get_node("/root/Main/TimerLabel").text = ""
			timer_label.add_theme_font_size_override("font_size", 52)
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
			print(gameOverNow())
			
