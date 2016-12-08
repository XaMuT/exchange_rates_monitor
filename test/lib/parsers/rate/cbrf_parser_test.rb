require 'test_helper'

module Parsers
  module Rate
    class CbrfParserTest < ActiveSupport::TestCase
      def setup
        @currency    = build(:currency, cbrf_code: 'R01235')
        @starts_from = Date.parse('2016-11-22')
        @ends_to     = Date.parse('2016-11-25')
      end

      def test_parse
        VCR.use_cassette("cbrf") do
          parser = Parsers::Rate::CbrfParser.new(@currency.code, @starts_from.to_s, @ends_to.to_s)
          assert { Hash == parser.parse.class }
          assert {
            (@starts_from..@ends_to).map {|d| d.strftime('%d.%m.%Y') } == parser.parse.keys
          }
          assert { %w(64,3580 63,6282 64,0087 64,6279) == parser.parse.values }
        end
      end
    end
  end
end
