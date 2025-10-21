extends Node2D

@export var mob_scene: PackedScene
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over() -> void:
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	show()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout() -> void:
	# Crea una nova instància de l'escena Mob.
	var mob = mob_scene.instantiate()
	mob.add_to_group("mobs")
	# Trieu una ubicació aleatòria a Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()  # offset → progress_ratio en Godot 4
	# Estableix la direcció de la multitud perpendicular a la direcció del camí.
	var direction = mob_spawn_location.rotation + PI / 2
	# Estableix la posició de la multitud a una ubicació aleatòria.
	mob.position = mob_spawn_location.position
	# Afegeix una mica d'aleatorietat a la direcció.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Tria la velocitat de la multitud.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	# Afegeix la multitud a l'escena principal.
	add_child(mob)
