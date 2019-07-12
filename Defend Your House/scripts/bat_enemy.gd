extends KinematicBody2D

export var SPEED = 15
export var MAX_HEALTH = 60
export var health_regenerate_power = 2
var health

var motion = Vector2()
var UP = Vector2(0,-1)
var canAttack = true
var rightMover = false #initial dummy value (Used for enemy Direction)
export var BatAttack = preload("res://Scenes/ExplosionScene.tscn")

func getDestVectorToAttack(playerPosition):

	####################################################################
	# The idea here is to calculate the distance between multiple vectors.
	# maximum of vector.x or vector.y can be taken as the distance between
	# two position. Then comparing this distance with other distance and noting
	# the minimum distance's house.
	####################################################################
	var count = 1	
	var minimumDistance
	var destinationVector
	
	for house in get_tree().get_nodes_in_group("houses"):
		var calDestVector = house.position - playerPosition
		var distance	
		
		if calDestVector.x > calDestVector.y:
			distance = calDestVector.x
		else:
			distance = calDestVector.y
			
		if count == 1:
			minimumDistance = distance
			destinationVector = calDestVector
		else:
			if minimumDistance > distance:
				minimumDistance = distance
				destinationVector = calDestVector
			
		count += 1
	destinationVector.normalized()
	return destinationVector

func _ready():	
	#Starting the regenerate timer
	$healthRegenerate.start()
	#Changing the direction
	health = MAX_HEALTH

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		if canAttack:
			canAttack = false
			$FireTimer.start()
			$Sprite.flip_h = false
			var fire = BatAttack.instance()

			#Adding the explosion on the level.
			get_parent().add_child(fire)
			fire.position = get_position()
			fire.position.x += 70
			fire.animateExplosion()
	else:		
		# new Code:
		var destinationVector = getDestVectorToAttack(position)
		motion = destinationVector * SPEED * delta
		#print(motion)
		move_and_slide(motion,UP)
		$Sprite.flip_h = false
		$Sprite/AnimationPlayer.play("walking")

func takePlayerCheeseDamage(damage):
	print(health)
	health -= damage;
	if(health <= 0):
		queue_free()
	

func _on_FireTimer_timeout():
	canAttack = true;

func _on_healthRegenerate_timeout():
	if health < MAX_HEALTH:
		health += health_regenerate_power
		print(health)


	
###############################################
# IMPORTANT NOTE:
# Check, Check Areas in RayCast settings.
# In order for the bat enemy to properly
# detect the object that the player needs to
# defend, the CollisionMask of the RayCast
# of the enemy should be the same as the 
# layer in which the protect object lies.
# 							- VeeHeiwa
###############################################


