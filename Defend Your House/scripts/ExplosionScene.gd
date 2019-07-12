extends Sprite

export var HOUSE_DAMAGE = 50

func _ready():
	pass

func animateExplosion():
	$AnimationPlayer.play("explode")

# This method is called after the explosion
# animation is done playing
func freeself():
	queue_free()

func _on_Area2D_area_entered(area):
	if area.name.substr(0,13) == "ProtectObject":
		area.giveDamage(HOUSE_DAMAGE)
