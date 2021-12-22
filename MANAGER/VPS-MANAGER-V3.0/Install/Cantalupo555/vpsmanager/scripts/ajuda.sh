#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Comandos disponíveis:" ; tput sgr0 ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "addhost " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Adicionar domínio 'host' a lista de domínios permitidos no Proxy Squid" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "alterarlimite " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Alterar o número máximo de conexões simultâneas permitidas para um usuário" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "alterarsenha " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Alterar a senha de um usuário" ; echo "" ;
tput setaf 2 ; tput bold ; printf '%s' "criarusuario " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Criar usuário SSH sem acesso ao terminal e com data de expiração" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "delhost " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Remover domínio 'host' da lista de domínios permitidos no Proxy Squid" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "expcleaner " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Remover usuários SSH expirados" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "mudardata " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Mudar a data de expiração de um usuário" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "remover " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Remover um usuário SSH" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "sshlimiter " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Limitador de conexões SSH simultâneas (deve ser executado em uma sessão screen)" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "sshmonitor " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Verifica o número de conexão simutânea de cada usuário" ; echo ""
tput sgr0