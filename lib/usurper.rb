module Usurper
  require 'open-uri'
  require 'csv'

  class Header
    include Enumerable
    extend Forwardable

    def_delegators :@data, :[]

    def initialize(data)
      @data = process(data)
    end

    def inspect
      "<Usurper::Header>"
    end

    def each(&block)
      @data.each(&block)
    end

    private

    def process(data)
      hash = {}
      data.each_with_index do |key, i|
        hash[i] = key
      end

      hash.freeze
    end
  end

  class Row
    extend Forwardable

    def_delegators :@data, :[]

    def initialize(row, header)
      @header = header
      @data = process(row)
    end

    def inspect
      "<Usurper::Row name='#{@data['name']}'>"
    end

    private

    def process(row)
      hash = {}
      row.each_with_index do |value, i|
        hash[ @header[i] ] = value
      end
      hash.freeze
    end
  end

  class CSV
    OPENEI_URL= 'http://en.openei.org/apps/USURDB/download/usurdb.csv'

    def initialize(csv_path=OPENEI_URL)
      @path = csv_path
    end

    def header
      Header.new(data.first)
    end

    def rows
      @rows ||= data[1..-1].map{|r| Row.new(r, header) }
    end

    private

    def data
      @data ||= ::CSV.parse( open(@path).read )
    end
  end
end
