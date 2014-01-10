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
system "sudo apt-get -y install sublime-text libreoffice speedcrunch shutter"
system "sudo apt-get -y install audacious vlc browser-plugin-vlc darktable inkscape gpicview font-manager"
system "sudo apt-get -y install chromium-browser"
system "sudo apt-get -y install grub-customizer hddtemp conky lm-sensors "
system "sudo apt-get -y install ruby racket rhino nodejs curl"

puts "-------------------------------"
puts " > Устанавливаем speedtest"
puts "-------------------------------"
system "sudo apt-get install -y python-pip"
system "sudo pip install speedtest-cli"

puts "------------------------------------------------"
puts " > Устанавливаем rvm для разработки под Rails"
puts "------------------------------------------------"
system "curl -L get.rvm.io | bash -s stable"
system "source ~/.rvm/scripts/rvm"
system "rvm requirements"
system "sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion"
system "rvm install 2.0.0"
system "rvm use 2.0.0 --default"
system "rvm rubygems current"
system "gem install rails"