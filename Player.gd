extends KinematicBody2D

export var speed = 250 # vitesse du perso
var screen_size # taille de la fenêtre de jeu

func _ready():
	screen_size = get_viewport_rect().size
	
func start(pos):
	position = pos
	show()

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0 # on flip si valeur negative
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
	else:
		$AnimatedSprite.set("frame", 0) # position par défaut
