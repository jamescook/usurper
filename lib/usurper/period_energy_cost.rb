module Usurper
  class PeriodEnergyCost
    attr_reader :period, :max, :rate, :adj, :sell, :unit, :tier_data

    def initialize(data={})
      @period = data[:period]
      @max    = data[:max]
      @rate   = data[:rate]
      @adj    = data[:adj]
      @sell   = data[:sell]
      @unit   = data[:unit]
      @tier_data = data[:tier_data]
    end
  end
end
