extends CharacterBody3D

@export var speed := 4.0
@export var mouse_sensitivity := 0.002
@export var sprint_speed: float = 7.0
@export var stamina_max: float = 100.0
@export var stamina_drain: float = 30.0
@export var stamina_recover: float = 18.0

var stamina: float = 100.0
var can_sprint: bool = true
var stamina_bar: ProgressBar = ProgressBar.new()

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	var hud := CanvasLayer.new()
	add_child(hud)
	hud.add_child(stamina_bar)
	stamina_bar.position = Vector2(20, 20)
	stamina_bar.size = Vector2(220, 24)
	stamina_bar.max_value = stamina_max
	stamina_bar.value = stamina
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -1.4, 1.4)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 9.8 * delta
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = 5.0
	var input_dir := Vector2.ZERO
	if Input.is_key_pressed(KEY_A):
		input_dir.x -= 1.0
	if Input.is_key_pressed(KEY_D):
		input_dir.x += 1.0
	if Input.is_key_pressed(KEY_W):
		input_dir.y -= 1.0
	if Input.is_key_pressed(KEY_S):
		input_dir.y += 1.0

	input_dir = input_dir.normalized()
	if stamina <= 0.0:
		can_sprint = false
	elif stamina >= 25.0:
		can_sprint = true

	var sprinting := can_sprint and Input.is_physical_key_pressed(KEY_SHIFT) and input_dir != Vector2.ZERO
	var current_speed := speed

	if sprinting:
		current_speed = sprint_speed
		stamina = maxf(stamina - stamina_drain * delta, 0.0)
	else:
		stamina = minf(stamina + stamina_recover * delta, stamina_max)

	stamina_bar.value = stamina
	var direction := global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)
	velocity.x = direction.x * current_speed
	velocity.z = direction.z * current_speed
	move_and_slide()
