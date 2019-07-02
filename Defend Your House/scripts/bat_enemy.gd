extends KinematicBody2D

export var SPEED = 30
var motion = Vector2()
var UP = Vector2(0,-1)
var canAttack = true
var rightMover = false #initial dummy value (Used for enemy Direction)
export var BatAttack = preload("res://Scenes/ExplosionScene.tscn")

func _ready():
	#Changing the direction
	if rightMover:
		motion.x = 1
	else:
		motion.x = -1

# This function will be called form the level scene
# to set the direction of the enemey.
func setMovingDirection(boolRightMover):
	rightMover = boolRightMover
	motion.x = 1

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		print($RayCast2D.get_collider().name)
		if canAttack:
			canAttack = false
			$FireTimer.start()
			print("Attacking")
			$Sprite.flip_h = false
			var fire = BatAttack.instance()

			#Adding the explosion on the level.
			get_parent().add_child(fire)
			fire.position = get_position()
			fire.position.x += 40
			fire.animateExplosion()
	else:		
		motion.x = 1 *  SPEED
		move_and_slide(motion,UP)
		$Sprite.flip_h = false
		$Sprite/AnimationPlayer.play("walking")

func _on_FireTimer_timeout():
	canAttack = true;


	
###############################################
# IMPORTANT NOTE:
# Check, Check Areas in RayCast settings.
# In order for the bat enemy to properly
# detect the object that the player needs to
# defend, the CollisionMask of the RayCast
# of the enemy should be the same as the 
# layer in which the protect object lies.
# - Vikram Bhavsar
###############################################