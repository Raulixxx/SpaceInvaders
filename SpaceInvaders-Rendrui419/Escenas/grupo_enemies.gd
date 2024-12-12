extends Node

var Enemy = preload("res://Escenas/enemy.tscn")
var EnemyBonus = preload("res://Escenas/enemy_bonus.tscn")

@onready var timer_disparo = $TimerDisparar

var lista_enemies = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TimerEnemyBonus.wait_time = randf_range(10.0,20.0)
	$TimerEnemyBonus.start()
	for j in range(4):
		lista_enemies.append([])
		for i in range(8):
			var enemy = Enemy.instantiate()
			enemy.global_position = Vector2(40 + 20 * i,40 + 20 * j)
			self.add_child(enemy)
			lista_enemies[j].append(enemy)
			enemy.connect("alien_eliminado", Callable(self,"eliminar_alien"))
			enemy.connect("alien_eliminado", Callable(get_parent(),"sumar_puntos_alien"))#1º parametro ¿donde esta la señal? en enemy; 2ºparametro ¿donde esta el destinatario de la llamada? en Main (padre del grupo_enemies); 3ºparametro Nombre de la función
			
func eliminar_alien(a):
	for fila in lista_enemies:
		for i in range(len(fila)-1): #i empieza en 0, len = longitud de la fila (en este caso es 8), -1 porque la lista empieza desde 0 hasta el 7 para tener los 8 valores
			if(a == fila[i]):
				fila.erase(i)
				#print("eliminado el alien de la lista")


func _on_timer_descender_timeout() -> void:
	print("Bajando")
	for fila in lista_enemies:
		for a in fila:
			if is_instance_valid(a): #Comprueba si el alien existe antes de moverlo
				a.position.y += 21


func _on_timer_disparar_timeout() -> void:
	var lista_aliens_vivos = []
	for fila in lista_enemies:
		for a in fila:
			if is_instance_valid(a) and !a.is_queued_for_deletion(): #!a.is_queued_for_deletion() ---> Si no esta en la cola para borrarse
				lista_aliens_vivos.append(a)
	if len(lista_aliens_vivos) > 0:
		var indice = int(floor(randf_range(0,len(lista_aliens_vivos)-1))) #Da un número aleatorio entre 0 y la longitud de la lista (pero randf_range no te da un número entero). floor redondea al número entero más cercano e int lo convierte a entero
		lista_aliens_vivos[indice].disparar()
		timer_disparo.wait_time = randf_range(2,5)


func _on_timer_enemy_bonus_timeout() -> void:
	var enemybonus = EnemyBonus.instantiate()
	self.add_child(enemybonus)
	enemybonus.connect("enemy_bonus_eliminado", Callable(get_parent(),"sumar_puntos_enemy_bonus"))#1º parametro ¿donde esta la señal? en enemybonus; 2ºparametro ¿donde esta el destinatario de la llamada? en Main (padre del grupo_enemies); 3ºparametro Nombre de la función
	
