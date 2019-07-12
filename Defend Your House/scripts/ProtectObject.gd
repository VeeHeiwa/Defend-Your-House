extends Area2D

# Provide value from the properties widow
export var HOUSE_HEALTH = 10000
var health
# Called when the node enters the scene tree for the first time.
func _ready():
	health = HOUSE_HEALTH

func giveDamage(damage):
	health -= damage
	if health < 0:
		print("house Destroyed:")
		
		queue_free()
