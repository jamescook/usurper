require 'set'
require_relative './csv.rb'
require_relative './period_energy_cost.rb'
require_relative './embedded_csv_data.rb'

module Usurper
  class Rate

    attr_reader :name, :utility, :energy_rates, :flat_demand_rates, :demand_rates

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
      @energy_rates      = process_energy_rates(row)
      @flat_demand_rates = process_flat_demand_rates(row)
      @demand_rates      = process_demand_rates(row)
    end

    private

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
