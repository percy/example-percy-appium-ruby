NPM=node_modules/.bin
VENDOR=vendor/bundle

.PHONY: install clean test test-advanced

$(NPM):
	npm install --no-save @percy/cli@^1.31.13

$(VENDOR):
	bundle config set path 'vendor/bundle'
	bundle install

install: $(NPM) $(VENDOR)

clean:
	rm -rf vendor node_modules .bundle

# Run against BrowserStack App Automate hub. Requires AA_USERNAME,
# AA_ACCESS_KEY, APP, PERCY_TOKEN env vars.
test test-advanced: install
	$(NPM)/percy app:exec -- bundle exec rspec spec/
