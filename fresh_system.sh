# Проект скрипта автоматической настройки свежей системы

# Репозитории которые нужно добавить

sudo apt-add-repository ppa:libreoffice/ppa							
sudo apt-add-repository ppa:webupd8team/sublime-text-2
sudo apt-add-repository ppa:n-muench/vlc
sudo apt-add-repository ppa:nilarimogard/webupd8
sudo apt-add-repository ppa:danielrichter2007/grub-customizer
sudo apt-add-repository ppa:chromium-daily/stable
sudo apt-add-repository ppa:brightbox/ruby-ng 
sudo apt-add-repository ppa:plt/racket
sudo apt-add-repository ppa:pmjdebruijn/darktable-release
sudo apt-add-repository ppa:inkscape.dev/stable


# Программы которые нужно установить

#- Редакторы
sudo apt-get install sublime-text libreoffice

#- Аудио-видео-фото
sudo apt-get install audacious vlc browser-plugin-vlc darktable inkscape

#- Сеть
sudo apt-get install chromium

#- Системное
sudo apt-get install grub-customizer hddtemp conky lm-sensors 

#- Для разработки
sudo apt-get install ruby racket rhino


# Подготовка шаблонов

#- Шаблон для скриптов на Ruby
which ruby 
'#!...'


#-- Дополнительные комплексы --#

# speedtest
sudo apt-get install python-pip
sudo pip install speedtest-cli

# прогон датчиков 
sudo sensors-detect

# hddtemp
(исправление переменных)