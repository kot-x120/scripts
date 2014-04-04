#!/bin/bash

# Скрипт добавления виртуального хоста ver.1.1 #

# Текущие проблемы:
# 	1. Не сохраняет пути для логов

echo " > --- $0 --- < "

# Проверяем права пользователя 
if [ $(whoami) != "root" ]; then
    echo ' > Недостаточно прав для запуска'
    exit 1
fi

name_of_site="$2"
apache2_site_conf="/etc/apache2/sites-available/$name_of_site"

# Функция добавления
add_site() {
    echo " > Добавляю сайт '$name_of_site'"
    dir="/var/www/$name_of_site/public_html"
    if [ -d $dir ]; then
    	echo " > Такой сайт уже существует"
    	exit 1
    else
    	# Создаем папку сайта
    	sudo mkdir /var/www/$name_of_site
    	sudo mkdir /var/www/$name_of_site/public_html
    
    	# ErrorLog && AccessLog
    	sudo touch /var/www/$name_of_site/error.log
    	sudo touch /var/www/$name_of_site/access.log

    	# Копируем настройки шаблона в файл сайта
    	cp /etc/apache2/sites-available/default $apache2_site_conf
    	ln -s $apache2_site_conf /etc/apache2/sites-enabled/$name_of_site

    	# Редактируем файл сайта 
    		# ServerAdmin && ServerAlias
    	sed -i "s/webmaster@localhost/webmaster@$name_of_site\n\tServerAlias www.$name_of_site/"	$apache2_site_conf	
    		# DocumentRoot && Directory
    	sed -i "s/DocumentRoot \/var\/www/DocumentRoot \/var\/www\/$name_of_site\/public_html/" $apache2_site_conf
    	sed -i "s/Directory \/var\/www\//Directory \/var\/www\/$name_of_site\/public_html\//" $apache2_site_conf	

    	#sed -i "s/\$\{APACHE_LOG_DIR\}/error.log/$dir\/error.log/" $apache2_site_conf
    	#sed -i "s/\$\{APACHE_LOG_DIR\}/access.log/$dir\/access.log/" $apache2_site_conf

    	# Меняем владельца
    	chown -R www-data:www-data $dir

    	# Включаем сайт
    	a2ensite $name_of_site

    	# Добавляем сайт в hosts
    	echo "127.0.0.1 $name_of_site" >> /etc/hosts

    	# Копируем шаблон стартовой страницы
    	cp /var/www/default/index.html $dir

    	# Перезапускаем apache2
    	sudo /etc/init.d/apache2 reload

    	echo " > Сайт '$name_of_site' успешно добавлен"
    	exit 0
    fi
}

# Функция удаления
rm_site() {
    echo " > Удаляю сайт $name_of_site"
    echo -n " > Подтвердите удаление (y/n): "

    read choice
    case "$choice" in 
    	y|Y) echo " > Удаление подтверждено"
			;;
		n|N) echo " > Удаление отменено"
			exit 0
			;;
		*) echo " > Некорректный ввод. Повторите запуск"
			exit 0
			;;
	esac
	if [ ! -d $dir ]; then
    	echo " > Такой сайт не существует"
    	exit 1
    else
    	dir="/var/www/$name_of_site"

    	# Выключаем сайт
    	a2dissite $name_of_site >>/dev/null 2>&1

    	# Удаляем каталог сайта, его конфигурационный файл и правим hosts
    	rm -r $dir
    	rm $apache2_site_conf
    	sed -i "/127.0.0.1 $name_of_site/d" /etc/hosts

    	# Перезагружаем apache2
    	/etc/init.d/apache2 reload >> /dev/null 2>&1

    	echo " > Сайт '$name_of_site' был успешно удален"
    	exit 0
    fi
}

# Функция списка локальных сайтов
ls_site() {
	echo " > Список сайтов: "
	ls --format=single-colum /etc/apache2/sites-available/ | grep -v "default*"
}

# Тело скрипта
if [ $1 = "add" ]; then
	if [ ! -z "$2" ]; then
		add_site
	else
		echo " > Не введено название сайта. Повторите запуск"
	fi
elif [ $1 = "rm" ]; then
	if [ ! -z $2 ]; then
		rm_site
	else
		echo " > Не введено название сайта. Повторите запуск"
	fi
elif [ $1 = "ls" ]; then
	ls_site
else
	echo " > Передан не верный аргумент: $1"
	echo " > Используйте $0 add(добавление) rm(удаление) name_of_site"
	exit 1
fi