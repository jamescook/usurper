require 'usurper/tier'
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
      @tier_data = data[:tier_data]
    end

    def tier_data
      @mapped_tier_data ||= @tier_data.map do |period, tier_data|
        Tier.new(tier_data.merge('period' => period))
      end
    end
  end
end
