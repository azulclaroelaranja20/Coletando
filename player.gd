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
		
		if objeto.is_in_group("componentes"):
			lixos_coletados += 1
			print("Lixos coletados pelo player: ", lixos_coletados)
			# Avisa a cena principal para atualizar o texto do HUD
			var cena_principal = get_tree().current_scene
			if cena_principal.has_method("registrar_lixo_coletado"):
				cena_principal.registrar_lixo_coletado()
			
			objeto.queue_free()
		
		if objeto.is_in_group("morri!"):
			get_tree().reload_current_scene()
