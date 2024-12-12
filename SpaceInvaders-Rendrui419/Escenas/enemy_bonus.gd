extends CharacterBody2D

signal enemy_bonus_eliminado
var velocidad = 40

func _process(delta: float) -> void:
	position.x -= velocidad * delta

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Destruido":
		emit_signal("enemy_bonus_eliminado")
		queue_free()

func explotar():
	$AnimationPlayer.play("Destruido")
