extends StaticBody2D

var golpes = 0

@onready var animacion = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	comprobar_golpes()

func destruir():
	golpes +=1
	comprobar_golpes()
	
func comprobar_golpes():
	if golpes == 0:
		animacion.play("Normal")
	elif golpes == 1:
		animacion.play("Dañado")
	elif golpes == 2:
		queue_free()
