extends StaticBody2D

var brickHealth = 1

func _on_CollisionShape2D_body_entered(body):
	if body.name == "Ball":
		brickHealth -= 1
		if brickHealth <= 0:
			get_node("/root/Main/ScoreLabel").update_score()
			queue_free()
