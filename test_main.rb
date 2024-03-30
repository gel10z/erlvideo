# frozen_string_literal: true

# module Testing is for
module Testing
  # i made my own class Date for using format 'dd.mm.yyyy'
  class Date
    def initialize(year, month, day)
      @year = year
      @month = month
      @day = day
    end

    attr_reader :year, :month, :day
  end

  # class License is for input data
  class License
    attr_accessor :paid_till, :max_version, :min_version
  end
end

def right?(date)
  true if date[6..9].to_i.between?(2010, 2024) && date[3..4].to_i.between?(1, 12) && date[0..1].to_i.between?(1, 31)
end

def date_converter(array)
  "#{array[0] % 100}.#{array[1].div(10)}#{array[1] % 10}"
end

def array_converter(date)
  [date.year % 100, date.month]
end

def define(date, num)
  a = []
  num.downto(0) do |i|
    if (date.month - i).positive?
      a.push(date_converter([date.year, date.month - i]))
    else
      a.push(date_converter([date.year - 1, 12 + date.month - i]))
    end
  end
  a
end

def compare(cur, paid)
  diff = cur.month - paid.month + (cur.year - paid.year) * 12
  return 0 if diff >= 7

  if diff.positive? && (cur.year >= paid.year)
    (7 - diff)
  else
    7
  end
end

def minmax(array, min, max)
  array = array.select { |i| (i <= max) } unless max.nil?
  array = array.select { |i| (i >= min) } unless min.nil?
  array
end

def versions(cur, paid, max, min)
  a = []
  num = compare(cur, paid)
  if num.zero?
    a = [max]
  else
    a = define(cur, num - 1) if num.eql?(7)
    a = define(paid, num - 1) unless num.eql?(7)
    a = minmax(a, min, max)
  end
  a
end

def inp(str, arr)
  loop do
    puts(str)
    input = gets.chomp
    if input.match?(/\d\d\.\d\d\.\d\d\d\d/) && right?(input)
      arr.push(input)
      return
    else
      puts('Введи дату в формате дд.мм.гггг')
    end
  end
end

def inpm(str, arr)
  loop do
    puts(str)
    input = gets.chomp
    if input.match?(/\d\d\.\d\d/) || input.empty?
      arr.push(input)
      return
    else
      puts('Введи версию в формате гг.мм')
    end
  end
end
