require 'spec_helper'
require_relative '../../lib/usurper/rates.rb'

describe Usurper::Rate do
  let(:csv) { Usurper::CSV.new(File.expand_path('spec/fixtures/usurdb.csv')) }
  subject { described_class.new(csv.rows.first) }

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
end
