#!/usr/bin/env python

from urllib2 import *
from platform import system
import sys
def clear():
    if system() == 'Linux':
        os.system("clear")
    if system() == 'Windows':
        os.system('cls')
        os.system('color a')
    else:
        pass
def slowprint(s):
    for c in s + '\n':
        sys.stdout.write(c)
        sys.stdout.flush()
        time.sleep(4. / 100)
banner = '''
========= ToolMaster =======\033[91m
========== NEW -ADM ========\033[96m
'''
print banner
def menu():
   print'''
\033[91m==============================
\033[91m [1] \033[92m>\033[96m Busqueda de DNS
\033[91m [2] \033[92m>\033[96m Busqueda de whois
\033[91m [3] \033[92m>\033[96m Busqueda de IP inversa
\033[91m [4] \033[92m>\033[96m Busqueda GeoIP
\033[91m [5] \033[92m>\033[96m Busqueda de subred
\033[91m [6] \033[92m>\033[96m Escaner de puertos
\033[91m [7] \033[92m>\033[96m Extraer enlaces 
\033[91m [8] \033[92m>\033[96m Transferencia de Zona
\033[91m [9] \033[92m>\033[96m HTTP Header
\033[91m [10]\033[92m>\033[96m Host Finder
\033[91m [11]\033[92m>\033[96m Informacion
\033[91m [0] \033[92m>\033[96m Salir
\033[91m==============================
'''
slowprint("   \033[1;34mNEW-AMD" + " - toolmaster")

menu()
def ext():
    ex = raw_input ('\033[92mContinuar/Exit OPCION [C / E]>  ')
    if ex[0].upper() == 'E' :
           print 'Saliendo!!!'
           exit()
    else:
           clear()
           print banner
           menu()
           select()

def  select():
  try:
    joker = input("\033[96mOpcion \033[92m0/\033[91m11 =  ")
    if joker == 2:
      dz = raw_input('\033[91mEscribe la IP o Dominio : \033[91m')
      whois = "http://api.hackertarget.com/whois/?q=" + dz
      dev = urlopen(whois).read()
      print (dev)
      ext()
    elif joker == 3:
      dz = raw_input('\033[92mEscribe la IP : \033[92m')
      revrse = "http://api.hackertarget.com/reverseiplookup/?q=" + dz
      lookup = urlopen(revrse).read()
      print (lookup)
      ext()
    elif joker == 1:
      dz = raw_input('\033[96mEscribe tu dominio :\033[96m')
      dns = "http://api.hackertarget.com/dnslookup/?q=" + dz
      joker = urlopen(dns).read()
      print (joker)
      ext()
    elif joker == 4:
      dz = raw_input('\033[91mEscribe la IP : \033[91m')
      geo = "http://api.hackertarget.com/geoip/?q=" + dz
      ip = urlopen(geo).read()
      print (ip)
      ext()
    elif joker == 5:
      dz = raw_input('\033[92mEscribe la IP : \033[92m')
      sub = "http://api.hackertarget.com/subnetcalc/?q=" + dz
      net = urlopen(sub).read()
      print (net)
      ext()
    elif joker == 6:
      dz = raw_input('\033[96mEscribe la IP : \033[96m')
      port = "http://api.hackertarget.com/nmap/?q=" + dz
      scan = urlopen(port).read()
      print (scan)
      ext()
    elif joker == 7:
      dz = raw_input('\033[91mEscribe tu dominio :\033[91m')
      get = "https://api.hackertarget.com/pagelinks/?q=" + dz
      page = urlopen(get).read()
      print(page)
      ext()
    elif joker == 8:
      dz = raw_input('\033[92mEscribe tu dominio :\033[92m')
      zon = "http://api.hackertarget.com/zonetransfer/?q=" + dz
      tran = urlopen(zon).read()
      print (tran)
      ext()
    elif joker == 9:
      dz = raw_input('\033[96mEscribe tu dominio :\033[96m')
      hea = "http://api.hackertarget.com/httpheaders/?q=" + dz
      der =  urlopen(hea).read()
      print (der)
      ext()
    elif joker == 10:
      dz = raw_input('\033[91mEscribe tu dominio :\033[91m')
      host = "http://api.hackertarget.com/hostsearch/?q=" + dz
      finder = urlopen(host).read()
      print (finder)
      ext()
    elif joker == 11:
      slowprint("ToolMaster \033[92m")
      slowprint(".....................")
      slowprint("NEW-ADMIN \033[96m")
      slowprint(".........................")
      ext() 
    elif joker == 0:
      print "Saliendo!!"
      ext()
  except(KeyboardInterrupt):
    print "\nCtrl + C -> Saliendo!!"
select()
