unit LibInformativo;

interface

implementation

end.

{
  
I - Index
C - Cadastro
V - Visualização

A tela index é única e imutável como tela principal.
A tela de loading não possui código provindo de uma biblioteca
por ser criada no momento da inicialização do aplicativo.

C001 - Clientes
C002 - Processos
C003 - Conversões
C004 - Multiempresa

V001 - Visualiza Conversões
V002 - Contatos
V003 - Visualiza Processos
  
Chave - 0: Chave utilizada para a edição de registros Pais.
Chave - 1: Chave utilizada para a Edição de registros Filhos.

Controle - 0: Modelo utilizado para controle do tipo de salvamento de telefone é Celular ou Fixo.
Controle - 2: Modelo utilizado para verificação de campo 0/-1 para checkbox.

Auxiliar - 0..n: Array usada para armazenar os dados que são tratados, tais como Checkboxes.

SetFieldsAndValues([Campos de Texto], [Campos Inteiros], [Campos Double], [Chaves], [Controles], [Valores dos Campos de Texto], [Valores dos Campos Inteiros], [Valores dos campos Double]);

Action or ActionItem - Variável do tipo string responsável pelo monitoramento da ação que está sendo executada em tempo de execução.
 - NULL - sem ação;
 - EDIT - edição;
 - NEW  - adição;
  
}
