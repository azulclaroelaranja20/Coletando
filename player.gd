extends CharacterBody2D


const SPEED = 80.0
var lixos_coletados=0

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1 * SPEED
		$Imagem.play("esquerda")
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1 * SPEED
		$Imagem.play("direita")
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1 * SPEED
		$Imagem.play("frente")
	if Input.is_action_pressed("ui_down"):
		velocity.y = 1 * SPEED
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
