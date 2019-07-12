extends Area2D

export var SPEED =	700
export var damage = 10
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

func _on_AttackObject_body_entered(body):
	#Calling the take damage function on the enemy
	# and freeing itself from the memory.
	if(body.name.substr(0,9) == "bat_enemy"):
		body.takePlayerCheeseDamage(damage)
		queue_free()
