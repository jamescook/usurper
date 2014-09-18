require 'set'
require 'json'
require_relative './csv.rb'
require_relative './period_energy_cost.rb'
require_relative './embedded_csv_data.rb'

module Usurper
  class Rate

    attr_reader :label, :name, :utility, :energy_rates, :flat_demand_rates, :demand_rates, :weekday_schedule

    def self.load_from_csv_row(row)
      new.tap do |rate|
        rate.load_from_csv_row(row)
      end
    end

    def inspect
      "<Usurper::Rate name='#{name}' utility='#{utility}'>"
    end

    def load_from_csv_row(row)
      @name              = row['name']
      @utility           = row['utility']
      @label             = row['label']
      @energy_rates      = process_energy_rates(row)
      @flat_demand_rates = process_flat_demand_rates(row)
      @demand_rates      = process_demand_rates(row)
      @weekday_schedule  = process_weekday_schedule(row)
    end

    private

    # Returns a nested structure showing what period applies for each month and hour of any given day
    def process_weekday_schedule(row)
      data = JSON.parse(row.to_hash['energyweekdayschedule'].gsub(/(\dL)/){ "\"#{$&}\"" })
      schedule = {1 => nil, 2 => nil, 3 => nil, 4 => nil, 5 => nil, 6 => nil, 7 => nil, 8 => nil, 9 => nil, 10 => nil, 11 => nil, 12 => nil}
      data.each_with_index do |month_data, i|
        #schedule[i+1] = month_data.map{|label| label[0].to_i + 1 }
        schedule[i+1] = month_data.map{|label| label.to_i + 1 }
      end

      schedule
    end

    def process_energy_rates(row)
      EmbeddedCsvData.new('energyratestructure', row, PeriodEnergyCost).process
    end

    def process_flat_demand_rates(row)
      EmbeddedCsvData.new('flatdemandstructure', row, PeriodEnergyCost).process
    end

    def process_demand_rates(row)
      EmbeddedCsvData.new('demandstructure', row, PeriodEnergyCost).process
    end
  end

  class Rates
    include Enumerable

    def initialize
      @rates = Set.new
    end

    def inspect
      "<Usurper::Rates size=#{@rates.size}>"
    end

    def self.load_from_csv(file_path)
      new.tap do |rates|
        rates.process_csv(CSV.new(file_path))
      end
    end

    def each(&block)
      @rates.each(&block)
    end

    def process_csv(data)
      data.rows.map do |row|
        @rates.add process_csv_row(row)
      end
    end

    private

    def process_csv_row(row)
      Rate.load_from_csv_row(row)
    end
  end
end
