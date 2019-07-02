extends KinematicBody2D

#Required Variables
export var SPEED = 200
export var JUMP = 700
export var GRAVITY = 2400
var motion = Vector2()
var UP = Vector2(0,-1)
var canshoot = true

# for instancing the throwable scene.
export var ThrowObjectScene = preload("res://Scenes/AttackObject.tscn")

func _ready():
	pass

func _physics_process(delta):
	#fall(delta)
	movement()
	checkCeiling()

func fall(delta):
	if is_on_floor():
		motion.y = 0
	# Apllying constant gravity to the player
	motion.y += GRAVITY * delta

func checkCeiling():
	#Checking if player is on ceiling and then reseting the jump 
	if is_on_ceiling():
		motion.y = 0
		pass
	
func movement():

	#reference -> Game Endevour platformer mechanics
	motion.x = -(int(Input.is_action_pressed("left"))) + (int(Input.is_action_pressed("right")))
	motion.x = motion.x * SPEED
	move_and_slide(motion,UP)

	#Whether to flip the animation or not
	if motion.x > 0:
		$Sprite.flip_h = true
	elif motion.x < 0:
		$Sprite.flip_h = false

	#has Attacked is used as a flag to play the 'fire' animation
	var hasAttacked = false
	if Input.is_action_pressed("fire"):
		if canshoot:
			canshoot = false
			$FireTimer.start()
			var fire = ThrowObjectScene.instance()
			get_parent().add_child(fire)
			fire.position = position
			fire.set_direction($Sprite.flip_h)
			hasAttacked = true
		
			
	$Sprite/PlayerAnimationPlayer.update_animation(motion,hasAttacked)


func _on_FireTimer_timeout():
	canshoot = true
