func shoot():
	# This checks if the "Muzzles" node exists to avoid errors
	if has_node("Muzzles"):
		# 'muzzle' represents each of your 5 Marker2Ds one by one
		for muzzle in $Muzzles.get_children():
			var b = bullet_scene.instantiate()
			
			# Add bullet to the level (owner), not the ship
			owner.add_child(b) 
			
			# Move the bullet to the exact spot of the current marker
			b.global_transform = muzzle.global_transform
	else:
		# This helps you troubleshoot if the node name is wrong!
		print("I can't find a node named Muzzles!")
