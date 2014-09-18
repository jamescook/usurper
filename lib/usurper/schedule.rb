module Usurper
  class Schedule
    def self.positions
      data = {}
      start = 0
      (0..11).each do |month|
        24.times do |i|
          data[month] ||= {}
          data[month][i] = start
          start = start + 1
        end
      end

      data
    end
  end
end
