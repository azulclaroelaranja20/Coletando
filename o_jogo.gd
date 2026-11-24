extends Node2D

@onready var label_tempo = $HUD/PanelContainer/HBoxContainer/Tempo
@onready var label_lixos = $HUD/PanelContainer/HBoxContainer/Lixos
@onready var mensagem_derrota = $HUD/Mensagem
@onready var timer = $Timer

var total_lixos: int = 0
var lixos_coletados_total: int = 0

func _ready() -> void:
	# Conta quantos nós estão no grupo "Lixos"
	total_lixos = get_tree().get_nodes_in_group("lixos").size()
	print("Total de lixos encontrados na fase: ", total_lixos) # Vai aparecer no console para ajudar a testar
	atualizar_interface()
	
	timer.timeout.connect(_on_timer_timeout)

func _process(_delta: float) -> void:
	if not timer.is_stopped():
		label_tempo.text = "Tempo: " + str(int(timer.time_left)) + "s"

func atualizar_interface() -> void:
	# Mostra ex: "Lixos: 1/5"
	label_lixos.text = "Lixos: %d/%d" % [lixos_coletados_total, total_lixos]

# Chamado pelo Player quando ele coleta um lixo
func registrar_lixo_coletado() -> void:
	lixos_coletados_total += 1
	atualizar_interface()
	
	# SÓ para o timer e vence se pegar TODOS os lixos
	if lixos_coletados_total >= total_lixos:
		timer.stop()
		print("Você venceu o jogo!")
		# Aqui você pode ativar uma tela de vitória se quiser

func _on_timer_timeout() -> void:
	if lixos_coletados_total < total_lixos:
		label_tempo.text = "Tempo: 0s"
		mensagem_derrota.visible = true
		
		if has_node("Player"):
			$Player.set_physics_process(false)
			
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("x"):
		get_tree().quit()
	if Input.is_action_pressed("y"):
		get_tree().change_scene_to_file("res://interface.tscn")
	if Input.is_action_pressed("z"):
		get_tree().change_scene_to_file("res://creditos.tscn")
	if Input.is_action_pressed("w"):
		get_tree().reload_current_scene()
