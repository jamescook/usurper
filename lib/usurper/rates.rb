require_relative './csv.rb'
require 'set'

module Usurper
  class Rate

    attr_reader :name, :utility

    def initialize(row)
      process(row)
    end

    def energy_rates

    end

    private 

    def process(row)
      @name = row['name']
      @utility = row['utility']
      @energy_rates = process_energy_rates(row)
    end

    def process_energy_rates(row)
 #WIP
 #"energyratestructure/period0/tier0max"=>"15.3",
 #"energyratestructure/period0/tier0rate"=>"0.1323",
 #"energyratestructure/period0/tier0adj"=>"0.0",
 #"energyratestructure/period0/tier0sell"=>nil,
 #"energyratestructure/period0/tier0unit"=>"kWh daily",
      row.to_hash.select{|k,v| k =~ /\Aenergyratestructure/ }
    end
  end

  class Rates
    include Enumerable

    def initialize(file_path=nil)
      @rates = Set.new
      process(CSV.new(file_path))
    end

    def each(&block)
      @rates.each(&block)
    end

    private

    def process(data)
      data.rows.each do |row|
        @rates.add process_row(row)
      end
    end

    def process_row(row)
      Rate.new(row)
    end
  end
end
