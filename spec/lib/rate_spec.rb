require 'spec_helper'
require_relative '../../lib/usurper/rates.rb'

describe Usurper::Rate do
  let(:csv) { Usurper::CSV.new(File.expand_path('spec/fixtures/usurdb.csv')) }
  subject { described_class.load_from_csv_row(csv.rows.first) }

  describe '#name' do
    it 'returns name of the rate' do
      expect(subject.name).to eq 'E-1 - Baseline Region P'
    end
  end

  describe '#utility' do
    it 'returns utility of the rate' do
      expect(subject.utility).to eq 'Pacific Gas & Electric Co'
    end
  end

  describe '#energy_rates' do
    it 'returns a structure representing the rate' do
      expect(subject.energy_rates).to be_an_instance_of(Array)
      expect(subject.energy_rates.first).to be_an_instance_of(Usurper::PeriodEnergyCost)
    end
  end
end
