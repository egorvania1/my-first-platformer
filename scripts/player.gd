extends CharacterBody2D


const SPEED: float = 130.0
const JUMP_VELOCITY: float = -320.0
var jump_count: int = 0
@export var max_jumps: int = 1
var jump_avaliable: bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#reset double jumps and jump check
	else:
		jump_count = 0 #recharge jumps
		if !jump_buffer_timer.is_stopped(): jump()
	
		
	# Handle jump.
	# jump if we have jumps or coyote timer is going
	jump_avaliable = (jump_count < max_jumps) or !coyote_timer.is_stopped()
	if Input.is_action_just_pressed("jump"):
		if jump_avaliable: jump()
		else: jump_buffer_timer.start()
			

	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.2
		

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("in_air")

	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#check if character was on floor for coyote jump timer
	#is_on_floor() updates only after move_and_slide()
	var was_on_floor = is_on_floor()
	
	move_and_slide() #MOVE!!!
	
	#start coyote jump if not on floor
	if was_on_floor && !is_on_floor():
		coyote_timer.start()

func add_jump():
	max_jumps += 1

func jump():
	velocity.y = JUMP_VELOCITY
	jump_count += 1 #take one jump
