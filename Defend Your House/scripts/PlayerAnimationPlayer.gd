extends AnimationPlayer

func _ready():
	pass

func update_animation(motion,hasAttacked):

	var anim = ""
	if hasAttacked:
		anim = "attack"
	elif motion.y < 0:
		anim = "jump"
	elif motion.x != 0:
		#going left	
		anim = "running"
	elif not current_animation == "attack":
		anim	 = "idle"
	
	play(anim)