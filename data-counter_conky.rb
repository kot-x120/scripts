#!/usr/bin/ruby
# coding: utf-8

# Счетчики обратного отсчета для консоли  ver.0.5
# Дата последнего редактирования 30.10.2013

require 'date'

today = Time.now
conky_data = File.new( ".conky_scripts/CDD", "w+" )
conky_data.puts " > Conky data date for my counter"

days_left_to_end_of_year = ((Time.local(2013,12,31) - today) / 60 / 60 / 24).to_i

# - Жизненные штуки

days_left_hosting_zakon_est = ((Time.local(2013,11,29) - today) / 60 / 60 / 24).to_i

# - Сессия

days_left_to_exam1 = ((Time.local(2013,11,26) - today) / 60 / 60 / 24).to_i

days_left_to_exam2 = ((Time.local(2013,12,02) - today) / 60 / 60 / 24).to_i

days_left_to_exam3 = ((Time.local(2013,12,04) - today) / 60 / 60 / 24).to_i

days_left_to_exam4 = ((Time.local(2013,12,06) - today) / 60 / 60 / 24).to_i

days_left_to_kons_exam5 = ((Time.local(2013,12,10) - today) / 60 / 60 / 24).to_i
days_left_to_exam5 = ((Time.local(2013,12,11) - today) / 60 / 60 / 24).to_i

days_left_to_kons_exam6 = ((Time.local(2013,12,18) - today) / 60 / 60 / 24).to_i
days_left_to_exam6 = ((Time.local(2013,12,19) - today) / 60 / 60 / 24).to_i

days_left_to_kons_exam7 = ((Time.local(2013,12,18) - today) / 60 / 60 / 24).to_i
days_left_to_exam7 = ((Time.local(2013,12,24) - today) / 60 / 60 / 24).to_i

conky_data.puts "Сегодня          |" + today.to_s
conky_data.puts "До конца года    |" + days_left_to_end_of_year.to_s
conky_data.puts "Hosting zakon-est|" + days_left_hosting_zakon_est.to_s
conky_data.puts ":01|Зачет -> ФинСредПред           |" + days_left_to_exam1.to_s
conky_data.puts ":02|Зачет -> УпрПроект             |" + days_left_to_exam2.to_s
conky_data.puts ":03|Зачет -> ЭкоТруд               |" + days_left_to_exam3.to_s
conky_data.puts ":04|Зачет -> УпрПерс               |" + days_left_to_exam4.to_s
conky_data.puts ":05|Экзамен -> Биржи               |" + days_left_to_kons_exam5.to_s + "/" + days_left_to_exam5.to_s
conky_data.puts ":06|Экзамен -> ВалТорг             |" + days_left_to_kons_exam6.to_s + "/" + days_left_to_exam6.to_s
conky_data.puts ":07|Экзамен -> УчБанк              |" + days_left_to_kons_exam7.to_s + "/" + days_left_to_exam7.to_s

# - Расписание подготовки к выпуску

days_left_to_begin_1 = ((Time.local(2013,11,25) - today) / 60 / 60 / 24).to_i
days_left_to_end_1 = ((Time.local(2013,12,15) - today) / 60 / 60 / 24).to_i

days_left_to_begin_2 = ((Time.local(2013,12,25) - today) / 60 / 60 / 24).to_i

days_left_to_begin_3 = ((Time.local(2013,12,30) - today) / 60 / 60 / 24).to_i

days_left_to_begin_4 = ((Time.local(2013,12,26) - today) / 60 / 60 / 24).to_i
days_left_to_end_4 = ((Time.local(2014,01,07) - today) / 60 / 60 / 24).to_i

days_left_to_begin_5 = ((Time.local(2014,01,9) - today) / 60 / 60 / 24).to_i
days_left_to_end_5 = ((Time.local(2014,01,15) - today) / 60 / 60 / 24).to_i

days_left_to_begin_6 = ((Time.local(2014,01,15) - today) / 60 / 60 / 24).to_i
days_left_to_end_6 = ((Time.local(2014,03,30) - today) / 60 / 60 / 24).to_i

days_left_to_begin_7 = ((Time.local(2014,04,01) - today) / 60 / 60 / 24).to_i
days_left_to_end_7 = ((Time.local(2014,04,06) - today) / 60 / 60 / 24).to_i

days_left_to_begin_8 = ((Time.local(2014,04,8) - today) / 60 / 60 / 24).to_i
days_left_to_end_8 = ((Time.local(2014,04,26) - today) / 60 / 60 / 24).to_i

days_left_to_begin_9 = ((Time.local(2014,05,26) - today) / 60 / 60 / 24).to_i
days_left_to_end_9 = ((Time.local(2014,06,10) - today) / 60 / 60 / 24).to_i

conky_data.puts ":08|Написать заявление на практику |" + days_left_to_begin_1.to_s + "/" + days_left_to_end_1.to_s
conky_data.puts ":09|Сдать зачетные книжки в деканат|" + days_left_to_begin_2.to_s
conky_data.puts ":10|Подготовка приказа о допуске   |" + days_left_to_begin_3.to_s
conky_data.puts ":11|Каникулы                       |" + days_left_to_begin_4.to_s + "/" + days_left_to_end_4.to_s
conky_data.puts ":12|Обзорный лекции к ГОСам        |" + days_left_to_begin_5.to_s + "/" + days_left_to_end_5.to_s
conky_data.puts ":13|Практика                       |" + days_left_to_begin_6.to_s + "/" + days_left_to_end_6.to_s
conky_data.puts ":14|Зачетная неделя по практике    |" + days_left_to_begin_7.to_s + "/" + days_left_to_end_7.to_s
conky_data.puts ":15|ГОСы                           |" + days_left_to_begin_8.to_s + "/" + days_left_to_end_8.to_s
conky_data.puts ":16|Предзащита диплома             |" + days_left_to_begin_8.to_s + "/" + days_left_to_end_8.to_s
conky_data.puts ":17|Защита диплома                 |" + days_left_to_begin_9.to_s + "/" + days_left_to_end_9.to_s

system "notify-send 'data-counter_conky.rb' 'Информации о датах успешно обновлены'"