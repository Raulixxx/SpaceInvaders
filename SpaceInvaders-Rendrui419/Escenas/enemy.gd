extends CharacterBody2D

var Misil = preload("res://Escenas/misil.tscn")

@onready var timer_movimiento = $TimerMovimiento
@onready var animation_player = $AnimationPlayer
@onready var spawn_point = $SpawnPoint

var origen = 0
var rango = 20
var paso = 7
var direccion = 1

signal alien_eliminado

func _ready() -> void:
	timer_movimiento.start()
	origen = self.position.x


func _on_timer_movimiento_timeout() -> void:
	self.position.x += paso * direccion
	if self.position.x >= rango + origen or self.position.x < origen - rango:
		direccion *= -1
		

func explotar():
	animation_player.play("Destruido")
	$AudioStreamPlayer.play()
	
	
func eliminar():
	emit_signal("alien_eliminado", self)
	get_parent().remove_child(self) #Voy al padre para que quite un hijo (a este mismo objeto enemigo). Es el padre el que elimina al hijo
	queue_free() #Elimina este mismo objeto de la memoria
	
func disparar():
	var misil = Misil.instantiate()
	misil.global_position = spawn_point.global_position
	get_parent().add_child(misil)
