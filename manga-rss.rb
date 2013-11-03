#!/usr/bin/ruby
# coding: utf-8

# Добавить предвыполняемый скрипт с временем запуска во все скрипты
# Сделать шаблоны под основные типы файлов
# Хорошая мысль, написать генератор пробелов для выравнивания консольного вызова в остальных языках
# Мысль -> скрипт для исправления статей на zakon-est. Автодополнение строк <p>
# Мысль -> качалка сериалов + вывод в conky
# Мысль -> написать свой трекер времени
# Мысль -> изучить побитовую арифметику

# Изменения в ver.0.4
# => 1. Работает со списком манги

# Изменения в ver.0.5
# => 1. Баг при выводе Скалы Кена
# => 2. Импорт ссылок на rss из файла

# Изменения в ver.0.5.1
# => 1. Вывод количества дней с момента обновления

# Изменения в ver.0.5.2
# => 1. Перевод на ООП модель
# => 2. Баг в Кулаке -> название главы прописными буквами <- исправлено
# => 3. Баги в ряде манг с номером главы <- исправлено

# Изменения в ver.0.6
# => 1. Ведение лог-файла с информацией
# => 2. Чтение лог-файла

# Изменения в ver.0.7
# => 1. Вывод зависит от аргументов -> | new | all | 

# => 1. Получаем на вход класса строку с URL
# => 2. Парсим дату последнего обновления и количество дней с момента обновления
# => 3. Поставить метку для if -> после сделать здесь ветвление | обновить | не обновить |
# => 	3.1. После дополнить установкой метки о наличии обновления в выводе в файл 
# => 4. Парсим имя
# => 5. Парсим главу и том
# => 6. Собираем это все в одном методе и вызываем все парсеры и затем печать в лог файл

# В conky вывод: Название манги: дней с обновления (new в случае обновления)

# - Определение класса

BEGIN { 
	puts "-" * 70
	puts "Парсер манги ver.0.6".center 70
	puts "-" * 70
}

class Manga
	# - Инициализация
	def initialize( input_data, today, id )
		@input_data = input_data[input_data.index("<item><title>")+13...input_data.index("</item>")]
		@id = id
		@today = today
	end

	# - Получаем дату обновления
	def get_last_build_date()
		@last_build_date = @input_data[@input_data.index( "<pubDate>" )+9...@input_data.index( "</pubDate>" )].split( / / )
		@last_build_date.delete_at(0); @last_build_date.pop; @last_build_date.pop;
		@last_build_date = Time.local(@last_build_date[2], @last_build_date[1], @last_build_date[0])
		@days_left = ( ( @today - @last_build_date ) / 60 / 60 / 24 ).to_i
	end

	# - Получение имени манги
	def get_name()
		@name_of_manga = @input_data[0...(@input_data =~ /\d/)]							
		@input_data = @input_data[@name_of_manga.length..@input_data.length-1]
	end

	# - Получение главы и тома
	def get_name_of_chapter()
		@name_of_chapter = @input_data[0...@input_data.index( "</title>" )].to_s
	end

	# - Вывод в файл
	def log_file()
		@log_file = File.open( "log_file", "a" )
		@log_file.puts " > id       : " + @id.to_s
		@log_file.puts " > Название : " + @name_of_manga.to_s
		@log_file.puts " > Глава    : " + @name_of_chapter.to_s
		@log_file.puts " > Дата up  : " + @last_build_date.to_s
		@log_file.puts " > Дней с up: " + @days_left.to_s
		@log_file.puts " > " + "-" * 70
		@log_file.close

		@conky_data = File.open( "conky_data_rss", "a" )
		@conky_data.puts @id.to_s + "|" + @name_of_manga.to_s + "|" + @days_left.to_s
		@conky_data.close
	end

	# - Выполнение методов и ветвления
	def compilation_data()
		get_last_build_date()
		get_name()
		get_name_of_chapter()
		log_file()
		
		puts " > id       : " + @id.to_s
		puts " > Название : " + @name_of_manga.to_s
		puts " > Глава    : " + @name_of_chapter.to_s
		puts " > Дата up  : " + @last_build_date.to_s
		puts " > Дней с up: " + @days_left.to_s
		puts " > " + "-" * 70
	end
end

# - Тело программы

i = 0
today = Time.now
log_file = File.new( "log_file", "w+" )
list_of_rss = File.readlines( "url_rss" )

log_file.puts " > " + "-" * 70 + " < "
log_file.puts " > Сегодня: " + today.to_s
log_file.puts " > " + "-" * 70 + " < " 
log_file.close

conky_data = File.new( "conky_data_rss", "w+" )
conky_data.close

manga_arr = Array.new(list_of_rss.size)

while i < list_of_rss.size
	system "wget --quiet -O temp_rss " + list_of_rss[i]
	input_data = File.open( "temp_rss" ).readline.to_s
	manga_arr[i] = Manga.new( input_data, today, i+1)
	manga_arr[i].compilation_data()

	i += 1
end