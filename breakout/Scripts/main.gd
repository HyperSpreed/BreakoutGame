extends Node2D

var lives = 3
@export var gameOverNow = false

func _ready():
	$WallLeftSide.add_to_group("Walls")
	$WallRightSide.add_to_group("Walls")
	$Ceiling.add_to_group("Walls")
	$Player.add_to_group("Paddle")
	get_node("/root/Main/HPLabel").text = "Lives: " + str(lives)
	

func lose_life():
	lives -= 1
	get_node("/root/Main/HPLabel").text = "Lives: " + str(lives)
	if lives <= 0:
		gameOverNow = true

func game_over():
	
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
	lives = 3
	var scoreMain = get_node("/root/Main/ScoreLabel")
	scoreMain.score = 0
	for brick in get_tree().get_nodes_in_group("Bricks"):
		brick.brickHealth = 1
		brick.show()
	
	gameOverNow = false

func _on_game_over_area_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
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
		#get_node("/root/Main/Ball").velocity.x = [0.45,0.5][randi()%2]
		#get_node("/root/Main/Ball").velocity.y = [0.8,0.9][randi()%2]
		#body.velocity.x = [0.45,0.5][randi()%2]
		#body.velocity.y = [0.8,0.9][randi()%2]
		
func _on_timer_timeout():
	print("Ended")
