require 'open-uri'

module Parsers
  module Rate
    class CbrfParser
      DATE_FORMAT = '%d/%m/%Y'.freeze

      attr_reader :currency_code, :starts_from, :ends_to

      def initialize(currency_code, starts_from, ends_to)
        @currency_code = currency_code
        @starts_from   = Date.parse(starts_from).strftime(DATE_FORMAT)
        @ends_to       = Date.parse(ends_to).strftime(DATE_FORMAT)
      end

      def parse
        @parse ||= Hash[response.scan(/(?<=Record Date=")(\d{2}\.\d{2}\.\d{4}).+<Value>(\d+,\d+)/)]
      end

      private

      def response
        open(url).read
      end

      def url
        "#{base_path}?#{query}"
      end

      def query
        "date_req1=#{starts_from}&date_req2=#{ends_to}&VAL_NM_RQ=#{currency_code}"
      end

      def base_path
        'https://www.cbr.ru/scripts/XML_dynamic.asp'
      end
    end
  end
end
