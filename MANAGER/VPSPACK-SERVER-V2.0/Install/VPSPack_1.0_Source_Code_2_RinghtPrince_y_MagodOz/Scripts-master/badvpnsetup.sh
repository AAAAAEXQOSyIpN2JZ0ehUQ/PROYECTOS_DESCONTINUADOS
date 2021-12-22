#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%50s%s%-20s\n' "BadVPN Setup 0.9 by Phreaker56" ; tput sgr0
if [ -f "/usr/local/bin/badvpn-udpgw" ]
then
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "O BadVPN já foi instalado com sucesso."
	echo "Para executar, crie uma sessão screen"
	echo "E execute o comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "E deixe a sessão screen rodando em segundo plano."
	echo "" ; tput sgr0
	exit
else
tput setaf 2 ; tput bold ; echo ""
echo "Este é um script que compila e instala automaticamente o programa"
echo "BadVPN em servidores Debian e Ubuntu para ativar o encaminhamento UDP"
echo "na porta 7300, usado por programas como HTTP Injector da Evozi."
echo "Permitindo assim a utilização do protocolo UDP para jogos online,"
echo "chamadas VoIP e outras coisas interessantes."
echo "" ; tput sgr0
read -p "Deseja continuar? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	echo ""
	echo "A instalação pode demorar bastante... seja paciente!"
	sleep 3
	apt-get update -y
	apt-get install screen wget gcc build-essential g++ make -y
	wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
	tar xvzf cmake*.tar.gz
	cd cmake*
	./bootstrap --prefix=/usr
	make 
	make install
	cd ..
	rm -r cmake*
	mkdir badvpn-build
	cd badvpn-build
	wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
	tar xf badvpn-1.999.128.tar.bz2
	cd bad*
	cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
	make install
	cd ..
	rm -r bad*
	cd ..
	rm -r badvpn-build
	echo "#!/bin/bash
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 512 --max-connections-for-client 8" > /bin/badudp
	chmod +x /bin/badudp
	clear
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "BadVPN instalado com sucesso."
	echo "Para usar, crie uma sessão screen"
	echo "E execute o comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "E deixe a sessão screen rodando em segundo plano."
	echo "" ; tput sgr0
	exit
else 
	echo ""
	exit
fi
fi