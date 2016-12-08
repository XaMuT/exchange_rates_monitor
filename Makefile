all: run

.PHONY: build
build:
	docker build -t exchange_rates_monitor .

.PHONY: run
run:
	docker run --rm -it -p 3000:3000 exchange_rates_monitor

.PHONY: test
test:
	docker run --rm -it exchange_rates_monitor bundle exec rails t

.PHONY: dev_bundle
dev_bundle:
	docker run --rm -it -v bundle:/usr/local/bundle -v $$PWD:/srv/exchange_rates_monitor exchange_rates_monitor bundle

.PHONY: dev_run
dev_run:
	docker run --rm -it -v bundle:/usr/local/bundle -v $$PWD:/srv/exchange_rates_monitor -p 3000:3000 exchange_rates_monitor

.PHONY: dev_test
dev_test:
	docker run --rm -it -v bundle:/usr/local/bundle -v $$PWD:/srv/exchange_rates_monitor exchange_rates_monitor bundle exec rails t

.PHONY: dev_console
dev_console:
	docker run --rm -it -v bundle:/usr/local/bundle -v $$PWD:/srv/exchange_rates_monitor exchange_rates_monitor bundle exec rails c

.SILENT:
