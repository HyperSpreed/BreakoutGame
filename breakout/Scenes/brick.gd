extends StaticBody2D

var brickHealth = 1
var initialHealth = 1

func _ready():
	brickHealth = initialHealth
	$CollisionShape2D.disabled = false

func _on_CollisionShape2D_body_entered(body):
	if body.name == "Ball":
		brickHealth -= 1
		if brickHealth <= 0:
			get_node("/root/Main/ScoreLabel").update_score()
			hide()
			$CollisionShape2D.disabled = true

func resetBrick():
	brickHealth = initialHealth
	show()
	$CollisionShape2D.disabled = false
