# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SleepLog, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to(:user) }  
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of(:clock_in) }
  end

  describe 'comparison of clock_in and clock_out' do
    context 'when clock_in is less than clock_out' do
      let(:log) { build(:sleep_log, clock_in: '2023-01-01 10:00 PM', clock_out: '2023-01-02 09:00 AM') }

      before do
        log.valid?
      end
      
      it 'does not return error for sleep log' do
        expect(log.errors[:clock_out]).to be_empty
      end
    end

    context 'when clock_in is greater than clock_out' do
      let(:log) { build(:sleep_log, clock_in: '2023-01-02 10:00 PM', clock_out: '2023-01-02 09:00 AM') }

      before do
        log.valid?
      end

      it 'does not return error for sleep log' do
        expect(log.errors[:clock_out]).not_to be_empty
        expect(log.errors[:clock_out]).to include(
          'must be greater than 2023-01-02 22:00:00 UTC'
        )
      end
    end

    context 'when clock_in is equal to clock_out' do
      let(:log) { build(:sleep_log, clock_in: '2023-01-02 10:00 PM', clock_out: '2023-01-02 10:00 PM') }

      before do
        log.valid?
      end

      it 'does not return error for sleep log' do
        expect(log.errors[:clock_out]).not_to be_empty
        expect(log.errors[:clock_out]).to include(
          'must be greater than 2023-01-02 22:00:00 UTC'
        )
      end
    end
  end

  describe '#clock_out' do
    let(:log) { create(:sleep_log, clock_in: '2023-01-01 10:30 PM') }

    before do
      log.update(clock_out: '2023-01-02 5:35 AM')
    end
    
    it 'calculates sleep duration after update' do
      expect(log.reload.duration).to eq(7.08)
    end
  end
end
