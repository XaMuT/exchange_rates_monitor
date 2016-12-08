require 'test_helper'

class RateTest < ActiveSupport::TestCase
  def setup
    @rate1 = create(:regular_rate, date: '2016-11-24')
    @rate2 = create(:forced_rate, ends_at: '2016-11-24T12:00:00Z', created_at: '2016-11-24T06:00:00Z')
    @rate3 = create(:regular_rate, date: '2016-11-25')
    @rate4 = create(:forced_rate, ends_at: '2016-11-26T12:00:00Z', created_at: '2016-11-25T18:00:00Z')
    @rate5 = create(:regular_rate, date: '2016-11-26')
  end

  def test_current
    travel_to DateTime.parse('2016-11-24T13:00:00Z') do
      assert { @rate1.id == Rate.current.id }
    end

    travel_to DateTime.parse('2016-11-24T11:00:00Z') do
      assert { @rate2.id == Rate.current.id }
    end

    travel_to DateTime.parse('2016-11-25T09:00:00Z') do
      assert { @rate3.id == Rate.current.id }
    end

    travel_to DateTime.parse('2016-11-26T09:00:00Z') do
      assert { @rate4.id == Rate.current.id }
    end

    travel_to DateTime.parse('2016-11-26T13:00:00Z') do
      assert { @rate5.id == Rate.current.id }
    end
  end
end
