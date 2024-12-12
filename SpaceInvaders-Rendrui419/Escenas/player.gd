extends CharacterBody2D

var laser = preload("res://Escenas/laser.tscn")

@onready var ptoLaser = $PuntoAparicionLaser
@onready var timer_disparo = $TimerDisparo
@onready var animacion = $AnimationPlayer

var direccion = Vector2()
var velocidad = 100
var puedo_disparar = true


func _physics_process(delta: float) -> void: #Se ejecuta en cada fotograma
	direccion.x = 0
	if Input.is_action_pressed("Right"):
		direccion.x += velocidad
	if Input.is_action_pressed("Left"):
		direccion.x -= velocidad
		
	if Input.is_action_just_pressed("Disparar") and puedo_disparar == true:
		var l = laser.instantiate()
		l.global_position = ptoLaser.global_position
		get_parent().add_child(l)
		puedo_disparar = false
		timer_disparo.start()
		$AudioStreamPlayer.play()
	
	position += direccion * delta
	
	if position.x >= 216.667:
		position.x = 216.667
	elif position.x <= 8:
		position.x = 8
	#move_and_slide(direccion)
	
	


func _on_timer_disparo_timeout() -> void:
	puedo_disparar = true
	
func destruir():
	animacion.play("Disparado")

func eliminar():
	get_tree().change_scene_to_file("res://Escenas/game_over.tscn")
	#if !self.is_queued_for_deletion(): #Si no estoy en cola para eliminarme. Si queremos eliminar algo que el juego ya tiene en cola para eliminar, da error.
		#get_parent().remove_child(self) #El nodo padre (main) quita uno de sus nodos hijos (player)
		#queue_free()
