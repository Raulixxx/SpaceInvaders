extends Node

var puntos = 0
@onready var textPuntos = $VBoxContainer/LabelPuntos

func _ready() -> void:
	$AudioStreamPlayer.play() 

func sumar_puntos_alien(a):
	puntos += 100
	textPuntos.text = str(puntos) #str intenta convertir la variable puntos a texto

func sumar_puntos_enemy_bonus():
	puntos += 500
	textPuntos.text = str(puntos) #str intenta convertir la variable puntos a texto
