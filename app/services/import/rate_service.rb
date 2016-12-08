module Import
  class RateService
    class << self
      def call(currency, starts_from, ends_to = nil, parser: Rails.configuration.container[:rate_parser])
        ends_to ||= starts_from
        rates_by_date_hash = parser.new(currency.code, starts_from, ends_to).parse
        import rates_by_date_hash, currency
      end

      private

      def import(hash, currency)
        hash.lazy.each do |k,v|
          date = Date.parse(k).iso8601
          currency.regular_rates.find_or_initialize_by(date: date).tap do |rate|
            rate.value = v.tr(',','.').to_f
            rate.save
          end
        end
      end
    end
  end
end
