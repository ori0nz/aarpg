class_name Player extends CharacterBody2D

# The direction the character is facing (one of 4 cardinal directions).
var cardinal_direction: Vector2 = Vector2.DOWN
# The player's current input vector.
var direction: Vector2 = Vector2.ZERO



@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine


func _ready() -> void:
	state_machine.initialize(self)
	

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Get a normalized input direction vector from the Input Map.
	direction = Input.get_vector("left", "right", "up", "down")
	
	
	# Move the character and handle collisions.
	move_and_slide()


# Determines and updates the character's facing direction (cardinal_direction).
# Returns true if the direction changed, false otherwise.
func set_direction() -> bool:
	# If there is no input, do nothing.
	if direction == Vector2.ZERO:
		return false
		
	var new_dir: Vector2
	
	# Prioritize horizontal direction if movement is mostly horizontal.
	if abs(direction.x) > abs(direction.y):
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	# Otherwise, use vertical direction.
	else:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	# If the direction hasn't changed, do nothing.
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	
	# Flip the sprite horizontally based on the direction.
	# Assumes the base sprite faces right.
	if cardinal_direction == Vector2.LEFT:
		sprite.scale.x = -1
	elif cardinal_direction == Vector2.RIGHT:
		sprite.scale.x = 1
	
	return true

# Plays the correct animation based on the current state and direction.
func update_animation(state: String) -> void:
	animation_player.play(state + "_" + get_anim_direction())


# Returns a string name for the current animation direction.
func get_anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else: # Covers both LEFT and RIGHT
		return "side"
