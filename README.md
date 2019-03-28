# blockusers
Script que bloqueia usuários no Active Directory baseados em uma consulta no MariaDB

Esse script foi criado com o intuito de bloquear o acesso à internet dos usuários de um domínio que não lancarem suas tarefas diariamente no sistema de controle de tarefas.

Ele funciona executando uma query no banco de dados do sistema e adicionando esses usuários a um grupo do AD.

Em um proxy squid deverá estar configurada uma ACL que boqueia totalmente o acesso dos usuários que pertencam a esse grupo à internet. Para melhor funionamento essa ACL deverá ser a primeira da lista.

Requisitos:

1 - MariaDB Connector ODBC
https://downloads.mariadb.org/connector-odbc/

2 - Active Directory Function Library
https://www.autoitscript.com/forum/files/file/355-ad-active-directory-udf/

3 - Computador Windows pertencente ao AD

Instalação / Compilação

1 - Certifique-se que a máquina que irá executar o script está adiconada ao dominio desejado e que o usuário que irá executar o script tenha permissão de escrita no grupo dos usuários bloqueados

2 - Crie um grupo no AD que irá conter os usuários bloqueados (default blocked)

3 - Crie uma ACL no Squid e bloqueie o acesso ao grupo criado

4 - Instale o Connector na máquina que irá executar o script

5 - Baixe os arquivos desse git e coloque em uma pasta

6 - Baixe a extensão AD Library e extraia na mesma pasta

7 - Na linha 26 colocar os parâmetros de conexão

8 - Na linha 29 colocar a query que retorne os nomes de usuários

9 - Compile o script com o AutoIt

10 - Colocar o script no agendador de tarefas do Windows

O Remove Bloqueio funciona para alguem que não tem acesso ao grupo diretamente possa remover um usuário do bloqueio.

1 - Na linha 10 e 16 coloque uma senha de segurança para evitar acessos indesejados.

2 - Na linha 40 coloque o nome do grupo no AD que irá conter os usuários bloqueados (default blocked)

3 - Na linha 20 coloque um usuário que tenha permissão de escrita no grupo de usuários bloqueados.
  3.1 Apesar da sugestão ser o administrador, não faça isso, crie um específico para esse fim.

4 - Compile com o AutoIt
