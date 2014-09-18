require 'bigdecimal'

module Usurper
  class Tier
    attr_reader :period, :max, :unit, :period, :attributes

    def initialize(attributes={})
      @attributes = attributes
      @period = attributes.fetch('period')
      @max    = attributes['max']
      @unit   = attributes['unit']
    end

    def rate
      if attributes['rate']
        BigDecimal.new(attributes['rate'])
      end
    end

    def adj
      if attributes['adj']
        BigDecimal.new(attributes['adj'])
      end
    end

    def sell
      if attributes['sell']
        BigDecimal.new(attributes['sell'])
      end
    end

    def total_rate
      if rate && adj
        rate + adj
      else
        rate
      end
    end
  end
end
