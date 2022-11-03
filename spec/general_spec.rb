# frozen_string_literal: true

require './lib/general'

describe General do
  let(:repo) { 'Empty_repo' }
  let(:data) { {id: '1', attribute: 'test'} }
  let(:general) { General.new(data, repo)}
  describe '#initialize' do
    it 'exists and has readable attributes' do
      expect(general).to be_a General
      expect(general.id)
      expect(general.attribute).to eq 'test'
    end
  end

  describe '#update' do
    it 'can change an attribute' do
      general.update({attribute: 'second_test'})
      expect(general.attribute).to eq("second_test")
    end
  end
end
