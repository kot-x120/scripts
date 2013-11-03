#!/bin/sh

#Функция добавления

add_site()
        {
        echo "----------------------------------"
        echo "Добавление нового сайта "
        sleep 1
        echo -n  "Введите имя сайта: "
        #Ждем ввода  имени сайта
        while read SITE
        do
        if
                [ "$SITE" != "" ]
        then
        DIR="/var/www/$SITE"
        FILE="/etc/apache2/sites-available/$SITE"

                if
                        [ -d $DIR ]
                then
                        echo "Такой сайт уже существует "
                        exit 1
                else

                #Создаем файл с настройками из копии исходного
                cp /etc/apache2/sites-available/default $FILE
                ln -s $FILE /etc/apache2/sites-enabled/$SITE

                #Редактируем наш файл
                sed -i "s/*/$SITE/" $FILE
                sed -i "/<VirtualHost $SITE:80>/i NameVirtualHost $SITE:80" $FILE
                sed -i "s/default/$SITE/g" $FILE
                sed -i "s/webmaster@localhost/webmaster@$SITE/" $FILE
                sed -i "/DocumentRoot \/var\/www\/$SITE/i ServerAlias www.$SITE" $FILE
                sed -i "/ServerAlias www.$SITE/i Servername $SITE" $FILE

                #Создаем необходимые каталоги
                mkdir $DIR
                #mkdir $DIR/cgi-bin

                #Меняем их владельца
                chown -R www-data:www-data $DIR

                #Включаем сайт
                a2ensite $SITE >> /dev/null 2>&1

                #Добавляем наш сайт в хосты
                echo "127.0.0.1 $SITE" >> /etc/hosts
                #cp /var/www/default/index.html $DIR/index.html
                /etc/init.d/apache2 restart  >> /dev/null 2>&1
                chmod 777 -R /var/www/
                echo "Сайт $SITE успешно добавлен"
                exit 0
                fi
        fi
        echo "Вы не ввели название."
        echo -n  "Введите имя сайта или ^Z для выхода: "
        done
        }

#Функция удаления

rm_site()
        {
        echo "Удаление сайта"
        sleep 1
        echo -n  "Введите имя сайта: "
        while read SITE
        do
        if
                [ "$SITE" != "" ]
        then
                DIR="/var/www/$SITE"
                FILE="/etc/apache2/sites-available/$SITE"

                if
                        [ -d $DIR ]
                then
                        a2dissite $SITE >>/dev/null 2>&1

                      #Удаляем каталоги и файлы
                        rm -r  $DIR
                        rm /etc/apache2/sites-available/$SITE
                        sed -i "/127.0.0.1 $SITE/d" /etc/hosts
                        /etc/init.d/apache2 reload >> /dev/null 2>&1
                        echo "Сайт $SITE был успешно удален"
                        exit 0
                else
                echo "Сайта $SITE нет на сервере"
                exit 1
                fi
        fi
        echo "Вы не ввели название."
        echo -n  "Введите имя сайта или ^Z для выхода: "
        done
        }

 

#Проверяем права пользователя 

  if
                [ $(whoami) != "root" ]
        then
                echo 'You must be root.'
                exit 1
        fi

#Процедура добавления удаления 

        if
                [ "$1" = "" ]
        then

         #Если запустили без параметров
        echo "Неверный параметр. "

        echo "Используйте add для добавления и remove для удаления"
        exit 1
        else
                case $1 in
                add)
                add_site #Добавляем сайт
                ;;
                remove)
                rm_site #Удадяем сайт
                ;;
                esac
        fi