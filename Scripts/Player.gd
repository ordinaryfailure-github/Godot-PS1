extends KinematicBody

onready var camera = get_node("Camera")
onready var raycast = get_node("RayCast")

export var sensitivity = 0.25

export var speed = 1.75
export var drag = 0.6
export var gravity = -80

var move_vec = Vector3()
var velocity = Vector3()

var normal

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _physics_process(delta):
	move_vec = Vector3.ZERO
	normal = raycast.get_collision_normal()
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if Input.is_action_pressed("move_forward"):
			move_vec += Vector3.FORWARD
			
		if Input.is_action_pressed("move_backward"):
			move_vec += Vector3.BACK
			
		if Input.is_action_pressed("move_left"):
			move_vec += Vector3.LEFT
			
		if Input.is_action_pressed("move_right"):
			move_vec += Vector3.RIGHT
			
		if Input.is_action_pressed("run"):
			speed = 2
		else:
			speed = 1.75
		
		move_vec = move_vec.normalized()
		move_vec = move_vec.rotated(Vector3.UP, rotation.y)
		
		velocity.y += gravity * delta
		
		if(is_on_floor()):
			velocity += speed * move_vec - velocity * Vector3(drag, 0, drag) - gravity * Vector3.UP * delta
		else:
			velocity += speed * move_vec - velocity * Vector3(drag, 0, drag) - gravity * Vector3.DOWN * delta
			
		velocity.y = move_and_slide_with_snap(velocity, -normal, Vector3.UP, true).y
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var movement = event.relative
		camera.rotation.x += -deg2rad(movement.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg2rad(-90), deg2rad(90))
		rotation.y += -deg2rad(movement.x * sensitivity)
