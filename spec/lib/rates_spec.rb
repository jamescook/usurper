require 'spec_helper'
require_relative '../../lib/usurper/rates.rb'

describe Usurper::Rates do
  subject { described_class.new(File.expand_path('spec/fixtures/usurdb.csv')) }

  describe '#first' do
    it 'returns the first rate' do
      expect(subject.first).to be_an_instance_of(Usurper::Rate)
    end
  end
end
