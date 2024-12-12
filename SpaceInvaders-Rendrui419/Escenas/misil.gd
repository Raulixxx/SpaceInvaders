extends Area2D

var speed = 150

func _process(delta: float) -> void:
	position.y += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Nave") or body.is_in_group("GrupoBloques"):
		body.destruir()
		queue_free() #borrar en memoria

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
