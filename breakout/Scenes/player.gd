extends CharacterBody2D

var speed = 10

func startGameKey():
	var timer_label = get_node("/root/Main/TimerLabel")
	var ballGameStart = get_node("/root/Main/Ball")
	
	timer_label.add_theme_font_size_override("font_size", 12)
	timer_label.text = "Use ENTER to START"
	
	ballGameStart.gameStart()
	print("GameStart")

func _physics_process(delta):
	var velocityPlayer = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		velocityPlayer.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocityPlayer.x += 1
	if Input.is_action_pressed("ui_accept"):
		startGameKey()
	move_and_collide(velocityPlayer*speed)
