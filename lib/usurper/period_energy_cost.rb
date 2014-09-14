module Usurper
  class PeriodEnergyCost
    attr_reader :period, :max, :rate, :adj, :sell, :unit

    def initialize(data={})
      @period = data[:period]
      @max    = data[:max]
      @rate   = data[:rate]
      @adj    = data[:adj]
      @sell   = data[:sell]
      @unit   = data[:unit]
    end
  end
end
