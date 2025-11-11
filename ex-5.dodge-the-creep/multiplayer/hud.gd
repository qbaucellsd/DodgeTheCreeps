extends CanvasLayer

signal start_game

func show_message(text):
	$Missatge.text = text
	$Missatge.show()
	$MessageTimer.start()

func show_game_over(score1: int, score2: int):
	var winner_text = ""
	if score1 > score2:
		winner_text = "Player 1 ha guanyat!"
	elif score2 > score1:
		winner_text = "Player 2 ha guanyat!"
	else:
		winner_text = "Empat!"
	show_message("Game Over\n" + winner_text)
	await $MessageTimer.timeout
	$Missatge.text = "Dodge the\nCreeps!"
	$Missatge.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func update_score2(score2):
	$ScoreLabel2.text = str(score2)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	emit_signal("start_game")

func _on_message_timer_timeout() -> void:
	$Missatge.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
