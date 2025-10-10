class_name AttackState extends State

var attacking: bool = false

@onready var walk: StateWalk = $"../Walk"
@onready var idle: StateIdle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect(end_attack)
	attacking = true
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	

func process(_delta: float) -> State:
	return null
	
	
func physics(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction ==Vector2.ZERO:
			return idle
		else:
			return walk
			
	return null
	

func handle_input(_event: InputEvent) -> State:
	return


func end_attack(_new_anim_name: String) -> void:
	attacking = false
