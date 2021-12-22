# phreaker56

### O que são esses scripts?

Esses scripts são pequenos programas executáveis escritos em linguagem shell script para simplificar ou automatizar tarefas em servidores VPS, Cloud ou Dedicado que rodem as distribuições Linux Debian e Ubuntu. Alguns deles também podem funcionar com o CentOS.

------------------------------------------

### VPS Manager 2.0

O VPS Manager 2.0 é conjunto de scripts feitos pra configurar automaticamente Proxy Squid e OpenSSH em servidores Linux, além de instalar comandos para facilitar o gerenciamento de usuários.<br>
Documentação: [VPS Manager 2.0 - Documentação.pdf](https://github.com/cantalupo555/phreaker56/blob/master/vpsmanager/VPS%20Manager%202.0%20-%20Documenta%C3%A7%C3%A3o.pdf)<br><br>
Comandos para instalar:

Primeiramente, atualize o sistema:

```bash
sudo apt-get update
sudo apt-get dist-upgrade -y
```

Agora execute:

```bash
wget https://raw.githubusercontent.com/cantalupo555/phreaker56/master/vpsmanager/vpsmanagersetup.sh
chmod +x vpsmanagersetup.sh
./vpsmanagersetup.sh
```
------------------------------------------

### TCP Tweaker 1.0

O TCP Tweaker 1.0 um script experimental que altera algumas configurações de rede do sistema Linux para melhorar a velocidade e estabilidade da conexão Proxy, VPN ou Túnel SSH. Caso as alterações não melhorem a navegação e estabilidade, basta executar o script novamente para desfazê-las.<br>
Comandos para executar:

```bash
wget https://raw.githubusercontent.com/cantalupo555/phreaker56/master/tcptweaker/tcptweaker.sh
chmod +x tcptweaker.sh
./tcptweaker.sh
```
------------------------------------------

### OpenVPNSetup

O OpenVPNSetup é uma versão modificada do script [openvpn-install](https://github.com/Nyr/openvpn-install/) para funcionar com o protocolo TCP com interface em português.<br>
Ele serve para facilitar a configuração de servidor OpenVPN e a criação de certificados de usuários (arquivos .ovpn) em servidores VPS ou Cloud Linux que rodem Debian, Ubuntu ou CentOS sem o utilizador precisar de conhecimento técnico.<br>
É recomendado a leitura deste tutorial caso deseje usar junto com Proxy no Android: [Como usar o Injector Python junto com OpenVPN no Android](https://github.com/cantalupo555/phreaker56/blob/master/Tutoriais/Injector_Python_OpenVPN_Android.pdf)<br>
Comandos para instalar:

```bash
wget https://raw.githubusercontent.com/cantalupo555/phreaker56/master/openvpn/openvpnsetup.sh -O /bin/openvpnsetup
chmod +x /bin/openvpnsetup
openvpnsetup
```
------------------------------------------

### User Backup 1.2

O User Backup 1.2 é um script experimental que serve para copiar todos os usuários, senhas e permissões de um servidor para outro, evitando o trabalho de ter que recriar todos os usuários novamente. Ferramenta útil para quem administra servidores de túnel SSH com muitos usuários.<br>
O script cria um arquivo chamado backup.vps que deve ser baixado e enviado para o novo servidor via SFTP. É importante manter esse arquivo em local seguro para manter a segurança do seu servidor.<br>
O script não captura nem envia nenhum dado a terceiros, ele apenas cria um pacote com os arquivos do sistema que contém as senhas criptografadas dos usuários.<br>
Para utilizadores do VPS Manager 2.0, o script também copia a base de dados dos usuários, o arquivo usuarios.db. Então se você for restaurar num novo servidor, configure-o com o VPS Manager 2.0 antes de restaurar o backup, assim evita o trabalho de ter que configurar o limite de conexões de cada usuário manualmente.<br>
Comandos para executar:
```bash
wget https://raw.githubusercontent.com/cantalupo555/phreaker56/master/userbackup/userbackup.sh
chmod +x userbackup.sh
./userbackup.sh
```
------------------------------------------

### BadVPN Setup 0.9

O BadVPN Setup 0.9 é um script em fase de testes que baixa e compila o código fonte e os pacotes necessários para instalar o programa <b>BadVPN</b> rodando na porta local 7300. Tornando possível o encaminhamento UDP em programas como HTTP Injector, necessário para fazer chamadas VoIP com protocolo UDP em aplicativos como Whatsapp.<br>
Comandos para executar:
```bash
wget https://raw.githubusercontent.com/cantalupo555/phreaker56/master/badvpn/badvpnsetup.sh
chmod +x badvpnsetup.sh
./badvpnsetup.sh
```