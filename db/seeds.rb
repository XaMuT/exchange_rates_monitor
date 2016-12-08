currency = Currency.find_or_create_by(name: 'United States Dollar', abbr: 'USD', cbrf_code: 'R01235')

today       = Date.current
starts_from = today - 7
ends_to     = today

Import::RateService.call(currency, starts_from.to_s, ends_to.to_s)
