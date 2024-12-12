extends Area2D

var  velocidad = 200

func _process(delta):
	position.y -= velocidad * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Aliens"):
		body.explotar()
		get_parent().remove_child(self) #Voy al padre para que quite un hijo (a este mismo objeto láser). Es el padre el que elimina al hijo
		queue_free() #Elimina este mismo objeto de la memoria

	elif body.is_in_group("GrupoBloques"):
		body.destruir()
		if !is_queued_for_deletion(): #!a.is_queued_for_deletion() ---> Si no esta en la cola para borrarse
			get_parent().remove_child(self) #Voy al padre para que quite un hijo (a este mismo objeto láser). Es el padre el que elimina al hijo
			queue_free() #Elimina este mismo objeto de la memoria

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
