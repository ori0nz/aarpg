class_name StateAttack extends State

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0
@onready var walk: StateWalk = $"../Walk"
@onready var idle: StateIdle = $"../Idle"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func enter() -> void:
	player.update_animation("attack")
	attack_anim.play("attack_" + player.get_anim_direction())
	animation_player.animation_finished.connect(end_attack)
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	attacking = false
	

func process(_delta: float) -> State:
	return null
	
	
func physics(_delta: float) -> State:
	player.velocity -= player.velocity  * decelerate_speed * _delta
	
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
