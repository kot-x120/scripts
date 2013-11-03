#!/usr/bin/ruby
# coding: utf-8

# Парсер манги ver.0.6 для conky

# - Определение класса

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
		if @days_left == 0
			system "notify-send 'manga-rss_conky.rb' 'Новая глава: " + @name_of_manga + ": " + @name_of_chapter + "'"
		end 
	end

	# - Получение имени манги
	def get_name()
		@name_of_manga = @input_data[0...(@input_data =~ /\d/)].chop!
		@input_data = @input_data[@name_of_manga.length..@input_data.length-1]
	end

	# - Получение главы и тома
	def get_name_of_chapter()
		@name_of_chapter = @input_data[0...@input_data.index( "</title>" )].to_s
	end

	# - Вывод в файл
	def log_file()
		@log_file = File.open( ".conky_scripts/log_file_manga_rss", "a" )
		@log_file.puts " > id       : " + @id.to_s
		@log_file.puts " > Название : " + @name_of_manga.to_s
		@log_file.puts " > Глава    : " + @name_of_chapter.to_s
		@log_file.puts " > Дата up  : " + @last_build_date.to_s
		@log_file.puts " > Дней с up: " + @days_left.to_s
		@log_file.puts " > " + "-" * 70
		@log_file.close

		@conky_data = File.open( ".conky_scripts/CDR", "a" )
		if @id < 10
			@id_str = "0" + @id.to_s
		else
			@id_str = @id.to_s
		end

		if @days_left == 0
			@conky_data.puts "id_" + @id_str + "|" + (@name_of_manga.to_s.ljust 39) + "|" + (@days_left.to_s.ljust 3) + "|1"
		else
			@conky_data.puts "id_" + @id_str + "|" + (@name_of_manga.to_s.ljust 39) + "|" + (@days_left.to_s.ljust 3) + "|"
		end
		@conky_data.close
	end

	# - Выполнение методов и ветвления (порядок выполнения важен)
	def compilation_data()
		get_name()
		get_name_of_chapter()
		get_last_build_date()
		log_file()
	end
end

# - Тело программы

i = 0
today = Time.now
log_file = File.new( ".conky_scripts/log_file_manga_rss", "w+" )
list_of_rss = File.readlines( ".conky_scripts/url_rss" )

log_file.puts " > " + "-" * 70 + " < "
log_file.puts " > Сегодня: " + today.to_s
log_file.puts " > " + "-" * 70 + " < " 
log_file.close

conky_data = File.new( ".conky_scripts/CDR", "w+" )
conky_data.puts " > Conky data RSS for my manga"
conky_data.close

manga_arr = Array.new(list_of_rss.size)

while i < list_of_rss.size
	system "wget --quiet -O .conky_scripts/temp_rss " + list_of_rss[i]
	input_data = File.open( ".conky_scripts/temp_rss" ).readline.to_s
	manga_arr[i] = Manga.new( input_data, today, i+1)
	manga_arr[i].compilation_data()

	i += 1
end

system "rm .conky_scripts/temp_rss"
system "notify-send 'manga-rss_conky.rb' 'Информация о манге была успешно обновлена'"