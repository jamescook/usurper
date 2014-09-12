require 'spec_helper'
require_relative '../../lib/usurper/csv.rb'

describe Usurper::CSV do
  subject { described_class.new(File.expand_path('spec/fixtures/usurdb.csv')) }

  describe '#header' do
    it 'returns the header' do
      expect(subject.header).to be_an_instance_of(Usurper::Header)
    end
  end

  describe '#rows' do
    it 'returns the rows' do
      expect(subject.rows.size).to eq 5
    end

    it 'returns Row objects' do
      expect(subject.rows.first).to be_an_instance_of(Usurper::Row)
    end
  end
end
