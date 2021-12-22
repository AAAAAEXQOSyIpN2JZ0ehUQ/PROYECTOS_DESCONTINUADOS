#!/bin/bash
cd
if [ $(id -u) != 0 ]
then
echo "Execute o script como root"
exit
fi
echo -e "\033[1;30mInstalando...\033[0m"
mkdir /etc/VpsPackdir 2>/dev/null
mkdir /etc/VpsPackdir/limite 2>/dev/null
mkdir /etc/VpsPackdir/senha 2>/dev/null
rm -rf /bin/limite 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/RicKbrL/VpsPack/master/limite > /bin/limite
chmod +x /bin/limite
rm -rf /bin/criarusuario 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/RicKbrL/VpsPack/master/criarusuario > /bin/criarusuario
chmod +x /bin/criarusuario
rm -rf /bin/deletarusuario 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/RicKbrL/VpsPack/master/deletarusuario > /bin/deletarusuario
chmod +x /bin/deletarusuario
rm -rf /bin/redefinirusuario 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/RicKbrL/VpsPack/master/redefinirusuario > /bin/redefinirusuario
chmod +x /bin/redefinirusuario
rm -rf /bin/vpspack 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/RicKbrL/VpsPack/master/vpspack > /bin/vpspack
chmod +x /bin/vpspack
rm -rf /bin/speedtest.py 2>/dev/null
wget -o /dev/null -O- https://raw.githubusercontent.com/RicKbrL/VpsPack/master/speedtest.py > /bin/speedtest.py
chmod +x /bin/speedtest.py
clear
echo -e "\033[1;32mInstalacao concluida\n\033[1;30mExecute:"
echo -e "\n\033[1;32mvpspack \033[1;30mMenu com opcoes"
echo -e "\033[1;32mcriarusuario \033[1;30mCriar usuario com data e limite"
echo -e "\033[1;32mdeletarusuario \033[1;30mDeletar usuario ou apenas desconectar"
echo -e "\033[1;32mredefinirusuario \033[1;30mAlterar data, senha, etc, de um usuario"
echo -e "\033[1;32mlimite \033[1;30mLimite de logins simultaneos\033[0m"
rm -rf install
