#!/usr/bin/ruby
# coding: utf-8
# Добавить:
# => 1. Ветвление (ноутбук/PC) 
# => 2. Настройку git 
# => 3. Установку Dropbox 
# => 4. Настройку conky hddtemp bashrc 
# => 5. Скрипт сборщик параметров, conky и т.д.

puts "-------------------------------"
puts "  Fresh system script ver.0.1"
puts "-------------------------------"
puts " > Добавляем репозитории"
puts "-------------------------------"

system "sudo apt-add-repository ppa:libreoffice/ppa"
system "sudo apt-add-repository ppa:webupd8team/sublime-text-2"
system "sudo apt-add-repository ppa:n-muench/vlc"
system "sudo apt-add-repository ppa:nilarimogard/webupd8"
system "sudo apt-add-repository ppa:danielrichter2007/grub-customizer"
system "sudo apt-add-repository ppa:chromium-daily/stable"
system "sudo apt-add-repository ppa:brightbox/ruby-ng "
system "sudo apt-add-repository ppa:plt/racket"
system "sudo apt-add-repository ppa:pmjdebruijn/darktable-release"
system "sudo apt-add-repository ppa:inkscape.dev/stable"

puts "-------------------------------"
puts " > Обновляем список пакетов"
puts "-------------------------------"

system "sudo apt-get update && sudo apt-get upgrade"

puts "-------------------------------"
puts " > Устанавливаем программы"
puts "-------------------------------"
system "sudo apt-get install sublime-text libreoffice speedcrunch shutter"
system "sudo apt-get install audacious vlc browser-plugin-vlc darktable inkscape gpicview font-manager"
system "sudo apt-get install chromium"
system "sudo apt-get install grub-customizer hddtemp conky lm-sensors "
system "sudo apt-get install ruby racket rhino"

puts "-------------------------------"
puts " > Устанавливаем speedtest"
puts "-------------------------------"
system "sudo apt-get install python-pip"
system "sudo pip install speedtest-cli"