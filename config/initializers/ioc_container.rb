Rails.application.configure do
  config.container = Hash.new

  config.container[:rate_parser]           = Parsers::Rate::CbrfParser
  config.container[:current_currency_abbr] = 'USD'
end
