module Usurper
  class EmbeddedCsvData
    def initialize(key, data, klass)
      @key = key
      @data = data
      @klass = klass
    end

    def process
      row_data.each do |key, value|
        rate_info = key.split('/')
        period_number = rate_info[1].sub('period','')
        attribute = rate_info[2].split(period_number.to_s).last
        periods[period_number] ||= {}
        periods[period_number][attribute] = value
      end

      return periods.map do |key, data|
        @klass.new(period: key,
                   max:    data['max'],
                   rate:   data['rate'],
                   adj:    data['adj'],
                   sell:   data['sell'],
                   unit:   data['unit'])
      end
    end

    private

    def periods
      @periods ||= {}
    end

    def row_data
      @row_data ||= @data.to_hash.select{|k,v| k =~ /\A#{@key}/ }
    end
  end
end
