extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

const DASH = 500.0
const DASH_TIME = 0.12
const DASH_COOLDOWN = 0.45

var double_jump = false
var dashing = false
var dash_timer = 0.0
var dash_cd = 0.0

var facing_dir = 1 # 1 = kanan, -1 = kiri

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	# cooldown dash berkurang terus
	if dash_cd > 0:
		dash_cd -= delta

	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump and double jump
	if is_on_floor():
		double_jump = true
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif double_jump == true and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY
		double_jump = false
	
	
	

	var direction = Input.get_axis("move_left", "move_right")

	# update arah hadap terakhir + flip sprite
	if direction > 0:
		facing_dir = 1
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		facing_dir = -1
		animated_sprite_2d.flip_h = true

	# Mulai dash (cek arah hadap dulu, lalu dash)
	if Input.is_action_just_pressed("dash") and (not dashing) and dash_cd <= 0:
		dashing = true
		dash_timer = DASH_TIME
		dash_cd = DASH_COOLDOWN

		# kalau lagi pencet arah, pakai itu. kalau tidak, pakai arah hadap terakhir
		if direction > 0:
			facing_dir = 1
		elif direction < 0:
			facing_dir = -1

	# =====================
	# LOGIKA DASH
	# =====================
	if dashing:
		dash_timer -= delta
		velocity.x = facing_dir * DASH

		if dash_timer <= 0:
			dashing = false

	else:
		# Gerak normal
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animasi (sederhana, mirip punyamu)
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")

	move_and_slide()
