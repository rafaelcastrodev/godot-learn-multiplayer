# Spawn players em posições diferentes (overlap)
# Seleção de personagem
# Sync rotacao do sprite
# Sync animacao
# Sync sons entre jogadores



#Explicação do MultiplayerInput Addon para Godot
#===============================================
#
#Com o 2 scripts auto-loads em ação:
#- MultiplayerInput
#- PlayerManager (solução provida pelo autor do addon)
#
#1) No _ready() da tela de JOIN dos jogadores os 2 sinais do PlayerManager são conectados
#player_joined(spawn_player) e player_left(delete_player)
#
#2) No _process(_delta) da tela de JOIN o método handle_join_input() do PlayerManager fica rodando escutando os jogadores que conectarão desconectarão.
#
#3) O processo handle_join_input() fica iterando sobre todos os joypads conectados por meio do método get_unjoined_devices do próprio PlayerManager
#O método get_unjoined_devices() captura todos os joypads conectados e ainda adiciona o teclado, considerando este último com o id = -1
#
#4) Se algum joypad conectado ou o próprio teclado pressionar a ação JOIN ele executa o método join(device) passando o dispositivo(id) que disparou a ação como parâmetro.
#
#5) Método join(device) verifica se o player pode ser adicionado ao pool de players conectados de acordo com a variável global MAX_PLAYERS por meio do método next_player(). Caso contrário é retornado o valor -1.
#
#6) Método join(device) adiciona ao dicionário player_data o novo jogador. Como PlayerManager faz as gerenciador completo dos dados do Player. Nesse momento da adição de um jogo 
#jogador, também são criados os dados e informações de um NOVO_JOGADOR.
#
#7) Método join(device) emite o sinal player_joined passando o jogador retornado pelo método next_player().
#
#8) De acordo com o sinal player_joined o método spawn_player() é executado
#
#9) Carrega e instancia o Player node. O player node do autor do addon possui um sinal leave(on_player_leave), ele é conectado nesse momento e vai disparar o método on_player_leave ao ser disparado.
#
#9.1) O método on_player_leave recebe o parâmetro referente ao jogador e aciona o método leave() do PlayerManager. O leave() no PlayerManager verifica se o jogador existe em player_data e o remove de lá, disparando o sinal player_left
#
#9.2) Sinal player_left está ligado ao método delete_player que acessa a variável player_nodes e executa queue_free() no node, bem como o remove de player_nodes.
#
#10) O método spawn_player adiciona a variável player_nodes o jogador(node) que acabou de ser instanciado.
#
#11) O método spawn_player recupera os dados do dispositivo que o jogador está conectado por meio do método get_player_device do PlayerManager.
#
#12) O método spawn_player execura o método init() do Player node.
#
#13) O método init do Player toma o número do jogador como id. Nele é usado o método DeviceInput de outra classe usada pelo MultiplayerInput addon.
#
#14) DeviceInput usa o id do dispositvo capturado pelo método get_player_device do PlayerManager para acessar os métodos de input, cujo o referente natural é a classe Input
#
#15) O Player usa no método _process a variável input para capturar os movimentos do jogador. E também faz a captura da ação correspondente ao disconnect para remover o player emitindo o sinal leave
#
#16) o método spawn_player adiciona o Player node à scene tree com add_child() e o posiciona randomicamente na tela.
#
#* Players que dão JOIN são inseridos em player_data
