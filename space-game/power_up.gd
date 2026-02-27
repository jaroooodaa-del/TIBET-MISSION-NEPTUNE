extends Area2D

func _on_body_entered(body):
	# We check if the 'body' (the thing that touched us) has the upgrade function
	if body.has_method("upgrade_fire_rate"):
		body.upgrade_fire_rate() # Trigger the upgrade on the player
		queue_free() # Delete the power-up so it can't be used twice
