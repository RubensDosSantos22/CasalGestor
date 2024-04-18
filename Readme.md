# PhoneAgend 2



## Justificativa:

​	O objetivo base do aplicativo é facilitar o acesso à determinadas informações e aplicativos. Dessa forma, ele é responsável pelo lançamento das conversões realizadas, e também sobre as informações de contato, código da empresa, assim como uma versão melhorada do multiempresa, uma seção com todos os acessos remotos e atualização do código fonte do sistema de trabalho integrada. A primeira versão foi criada originalmente no Delphi 7,e comportava várias funções que não diziam respeito às funções necessárias principais. dessa forma, foi feita essa atualização, que serve de estudo, melhoria e aprendizado referente ao Delphi.

## Atualizações:

Atualização 061.020.22.1050 e superiores: Implantação do sistema de configuração de bases. Essa nova função caregará os updates, criação de índices, irá portar novas telas que farão todas as configurações de dados das empresas de forma prática, assim como a configuração e edição de novos usuários nas mesmas empresas. A atualização acompanha a correção de Bugs no sistema.

## Funções Gerais:

- Cadastro:
    - Cadastro de clientes;
    - Cadastro de processos;

- Lançamentos:
    - Lançamento das conversões realizadas;

- Configurações:
    - Configuração do sistema PA3.

- Acessibilidade:
    - Visualização da Eficiência;
    - Visualização dos serviços que ainda não foram concluídos;
    - Atalho para acesso remoto das empresas clientes;
    - Botão que realiza a atualização do código fonte direto do servidor;
    - Função de multiempresa com botão para abrir o sistema de destino;
    - Botões de rápido acesso para aplicativos usados na realização dos serviços;

- Bases:
    - Adição, cópia e edição de usuários e bases de dados de clientes.
    - Cópia de cadastros da base branca para a vermelha.
    - Execução de Updates e criação/atualização dos Índices nas bases de clientes.
    - Configuração dos dados fiscais da base de dados.
    - Configuração dos padrões do sistema.

- Relatórios:
    - Clientes;
    - Processos;
    - Conversões;

## Especificando as funções:

- Os botões de acesso rápido, temos acesso aos aplicativos que são comumente usados na edição e trabalho do sistema.
- A visualização da eficiência, que é apresentada em forma de gráfico e ordenada por serviço, trazendo uma comparação entre o tempo previsto para finalizar e o tempo real de finalização, trazendo seu valor em porcentagem.
- A visualização dos serviços é feita com base na verificação de conclusão do mesmo, trazendo um índice que diz respeito ao mesmo se está no prazo, atrasando ou atrasado. Isso somente em serviços ainda não concluídos.
- O atalho para acesso remoto, diminui o trabalho para com as conexões de área de trabalho remota nas empresas, permitindo o acesso aos mesmos na tela inicial do sistema.
- O botão responsável pela atualização do código fonte, realiza uma chamada a um arquivo bat que possui um código responsável por puxar o código fonte mais recente diretamente do servidor.
- A função de multiempresa, substitui o aplicativo comumente usado para configurar mais de uma empresa em um mesmo computador.
- O cadastro de clientes guarda informações básicas necessárias para confirmar e lançar uma conversão, e armazenar os contatos das empresas clientes.
- O lançamento das conversões realizadas traz uma forma simples de finalização do trabalho de conversão, assim como uma visualização com filtros das já realizadas.
- O cadastro de processos, traz consigo uma lista simples que mostra o passo a passo de ações que devem ser executadas em determinados processos. Também traz consigo uma área de observações que é preenchida somente se necessário.
- As configurações de usuários, também serão feitas juntamente com a configuração dos dados da empresa. Serão feitos os básicos de adição e salvamento, porém, não será feita a exclusão dos mesmos por questões de segurança e integridade dos dados.
- A cópia dos cadastros, será feita em caso de adição de parte vermelha, ou de problemas com as replicações padrão. Nela serão copiadas as tabelas de cadastro da base de dados branca para a vermelha.
- Há um arquivo de updates e Índices a serem criados nas bases de dados. Estes serão configurados nas bases que se mosrtar necessário tal ação.
- A configuração de dados fiscais será feita configurando a tabela AGSINI.
- A configuração de dados fiscais será feita configurando a tabela MPADRAO.

## Padrões de arquivo:

​	Todas as Units que não fazem parte da seção principal de administração do sistema, possuem em seu início a sigla "Un". A Unit principal recebe o nome de Index e o projeto recebe o nome do aplicativo.

​	Na pasta do fonte, temos a pasta lib. Ela carrega as bibliotecas de importação e as bibliotecas de projeto (respectivamente as pastas import e project) as lib's de projeto possuem em suas iniciais a sigla Lib, e elas são responsáveis por 90% das ações de todo o sistema.

## Padrões de código:

I - Index;

C - Cadastro;

V - Visualização;

S - Configurações.

A tela index é única e imutável como tela principal.
A tela de loading não possui código provindo de uma biblioteca
por ser criada no momento da inicialização do aplicativo.

C001 - Clientes;

C002 - Processos;

C003 - Conversões;

C004 - Multiempresa.

V001 - Visualiza Conversões;

V002 - Contatos;

V003 - Visualiza Processos;

S001 - Configurador;

S002 - Configura Usuários;

S003 - Configura Padrões do sistema;

S004 - configura Fiscais.


Chave - 0: Chave utilizada para a edição de registros Pais.

Chave - 1: Chave utilizada para a Edição de registros Filhos.


Controle - 0: Modelo utilizado para controle do tipo de salvamento de telefone é Celular ou Fixo.

Controle - 1: Modelo utilizado para identificação de salvamento M/D (Master/Detail).

Controle - 2: Modelo utilizado para verificação de campo 0/-1 para checkbox.


Auxiliar - 0..n: Array usada para armazenar os dados que são tratados, tais como Checkboxes.

Action ou ActionItem - Variável do tipo string responsável pelo monitoramento da ação que está sendo executada em tempo de execução.

Tipo - Define o tipo de pesquisa ou qualquer outro tipo de informação que possa ser executada de mais de uma forma.

 - NULL - sem ação;
 - EDIT - edição;
 - NEW  - adição;

Variáveis que configuram permissões das telas no sistema.

PrmSrc - 0: Desabilita o uso da área de epsquisa dos formulários, que é ativada clicando na lupa abaixo do menu;
PrmSrc - 1: habilita o uso da área de epsquisa dos formulários, que é ativada clicando na lupa abaixo do menu.

Fontes usadas no sistema:

BIZ UDPGothic

Padrões de design:

 - PnlFd      - Deve ser imutável e sreá o parente do painel de fundo. Ficará no Index para manter a ordem das cores no menu
 - PnlFdL     - Correção de cores à esquerda (width = PnlFd / 2; align = left) 
 - PnlFdR     - Correção ed cores à direita  (width = PnlFd / 2; align = right)
 - PnlForm    - Será responsável por carregar as informações inetrnas das telas
 - PnlWorkShp - Shape do painel onde estarão os formulários
 - PnlMenu    - Menu geral do Sistema
 - PnlNav     - Carregará o cabeçalho do projeto
 - Img + Nome - Nomenclatura das imagens do projeto
 - PnlChild   - Painéis com funções especiais que deverão ficar ocultos

Nomenclaturas das animações:

 - anHover      + Nome do componente - Animação de quando colocar o mouse em cima de um componente
 - anUnhover    + Nome do componente - Animação de quando o mouse sai de cima de um componente
 - anVisible    + Nome do componente - Animação para mostrar um componente
 - anInvisible  + Nome do componente - Animação para esconder umm componente
 - anMov        + Nome do componente - Animação de movimentação de componentes         
 - anSize       + Nome do componente - Animação de tamanho de componentes (anSizeH para Height e anSizeW para Width)
 - anColor      + Nome do componente - Animação de cores de componenets (anColorB + Nome do componente para cor de borda) 