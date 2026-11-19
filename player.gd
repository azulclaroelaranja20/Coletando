extends CharacterBody2D


const SPEED = 80.0
var lixos_coletados=0

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1 * SPEED
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1 * SPEED
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1 * SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1 * SPEED
	move_and_slide()
	
	if velocity == Vector2.ZERO:
		$Imagem.play("parado")
	elif velocity.x == -1:
		$Imagem.play("esquerda")
	elif velocity.x == 1:
		$Imagem.play("direita")
	elif velocity.y == -1:
		$Imagem.play("frente")
	elif velocity.y == 1:
		$Imagem.play("trás")
	move_and_slide()
	
	if lixos_coletados == 5:
		$'Label'.visible = true
	
	for i in get_slide_collision_count():
		var colisao = get_slide_collision(i)
		var objeto = colisao.get_collider()
		
		if objeto.is_in_group("lixos"):
			lixos_coletados += 1
			print(lixos_coletados)
			objeto.queue_free()
		
		if objeto.is_in_group("morri!"):
			get_tree().reload_current_scene()
