extends RigidBody2D

func _ready() -> void:
	# Inicia l’animació
	$AnimatedSprite2D.play()
	
	# Obté totes les animacions disponibles i tria’n una a l’atzar
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	randomize()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]

# Aquest mètode es cridarà quan el mob surti de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
