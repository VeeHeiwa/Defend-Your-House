extends Area2D

export var SPEED =	700
var attackDirection = Vector2()

func _ready():
	pass

func set_direction(spriteHFlipOrientation):
	if spriteHFlipOrientation:
		attackDirection.x = 1
	else:
		attackDirection.x = -1

func _physics_process(delta):
	position.x += attackDirection.x * SPEED * delta