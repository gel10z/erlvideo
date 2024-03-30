# frozen_string_literal: true

require_relative './test_main'

puts("Тестирование в эрливидео\n")
loop do
  puts("Меню:\n1 - ввести данные\n0 - выход из программы")
  control = gets.chomp
  case control
  when '1'
    a = []
    inp('Текущая дата: ', a)
    inp('Оплачено до: ', a)
    inpm('Максимальная версия: ', a)
    inpm('Минимальная версия: ', a)
    a[0] = a[0].split('.').map!(&:to_i)
    a[1] = a[1].split('.').map!(&:to_i)
    current_date = Testing::Date.new(a[0][2], a[0][1], a[0][0])
    license = Testing::License.new
    license.paid_till = Testing::Date.new(a[1][2], a[1][1], a[1][0])
    license.max_version = license.min_version = nil
    license.max_version = a[2] unless a[2].empty?
    license.min_version = a[3] unless a[3].empty?
    puts 'Доступные версии: '
    p versions(current_date, license.paid_till, license.max_version, license.min_version)
  when '0' then puts('Пока!')
  else
    puts('Попробуем снова')
    gets
  end
  break if control.eql?('0')
end
