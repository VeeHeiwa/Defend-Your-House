extends Sprite

func _ready():
	pass

func animateExplosion():
	$AnimationPlayer.play("explode")

# This method is called after the explosion
# animation is done playing
func freeself():
	queue_free()
