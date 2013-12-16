#!/usr/bin/ruby
# coding: utf-8

time = Time.now()
puts time

puts ((Time.local(11,55) - time) / 60 / 60 / 24)
