extends Label

var score = 0

func _ready():
	text = "Score: 0"

func update_score():
	score += 1
	text = "Score: " + str(score)
	
