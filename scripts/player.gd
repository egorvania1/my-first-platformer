extends CharacterBody2D


const SPEED: float = 130.0
const JUMP_VELOCITY: float = -320.0
var jump_count: int = 0
@export var max_jumps: int = 1
var jump_avaliable: bool = true
var can_move: bool = true

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var death_timer: Timer = $DeathTimer

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#reset double jumps and jump check
	else:
		jump_count = 0 #recharge jumps
		if !jump_buffer_timer.is_stopped(): jump()
	
	
	# jump if we have jumps or coyote timer is going
	# I wonder if player can make extra jump while coyote timer is going...
	jump_avaliable = (jump_count < max_jumps) or !coyote_timer.is_stopped()
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	if can_move:
		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			if jump_avaliable: jump()
			else: jump_buffer_timer.start()
				
		if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y *= 0.2
		
		# Flip the sprite
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
			
		# Apply movement
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
		# Play animations
		if is_on_floor():
			if direction == 0:
				animation_player.play("idle")
			else:
				animation_player.play("run")
		else:
			animation_player.play("in_air")
	
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
	if jump_count != 0:
		animation_player.play("double_jump")
	jump_count += 1 #take one jump

func damage():
	can_move = false
	
	death_timer.start()
	Engine.time_scale = 0.5
	
	animation_player.play("death")
	velocity.x = 0
	velocity.y = 0
	#get_node("CollisionShape2D").queue_free()

	print("You died...")


func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
