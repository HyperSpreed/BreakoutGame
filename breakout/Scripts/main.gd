extends Node2D

var lives = 3

func _ready():
	get_node("/root/Main/HPLabel").text = "Lives: " + str(lives)

func lose_life():
	lives -= 1
	get_node("/root/Main/HPLabel").text = "Lives: " + str(lives)

func game_over():
	var BallSpeed = get_node("/root/Main/Ball")
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabel").text = "You Lost"
	get_node("/root/Main/TimerLabelLost").text = "Game Restarting in 5..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabelLost").text = "Game Restarting in 4..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabelLost").text = "Game Restarting in 3..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabelLost").text = "Game Restarting in 2..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabelLost").text = "Game Restarting in 1..."
	await get_tree().create_timer(1).timeout
	get_node("/root/Main/TimerLabelLost").text = ""
	get_node("/root/Main/TimerLabel").text = ""
	lives = 3
	get_node("/root/Main/HPLabel").text = "Lives: " + str(lives)
	var scoreMain = get_node("/root/Main/ScoreLabel")
	scoreMain.score = -1
	get_node("/root/Main/ScoreLabel").update_score()
	for Brick in get_tree().get_nodes_in_group("Bricks"):
		Brick.resetBrick()
	
	BallSpeed.BallSpeed = 400
	BallSpeed.position = Vector2(640,400)
	randomize()
	BallSpeed.VelocityBall.x = [0.45,0.5][randi()%2]
	BallSpeed.VelocityBall.y = [0.8,0.9][randi()%2]

func _on_game_over_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		if lives>1:
			get_node("/root/Main").lose_life()
			get_node("/root/Main/TimerLabel").text = "3..."
			await get_tree().create_timer(1).timeout
			get_node("/root/Main/TimerLabel").text = "2..."
			await get_tree().create_timer(1).timeout
			var timerlabelfontsize = get_node("/root/Main/TimerLabel")
			get_node("/root/Main/TimerLabel").text = "1..."
			await get_tree().create_timer(1).timeout
			get_node("/root/Main/TimerLabel").text = ""
			body.position = Vector2(640,400)
			body.velocity = Vector2(0,0)
			randomize()
			body.VelocityBall.x = [0.45,0.5][randi()%2]
			body.VelocityBall.y = [0.8,0.9][randi()%2]
		elif lives==1:
			game_over()

func _on_timer_timeout():
	print("Ended")
