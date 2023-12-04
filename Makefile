NPM=node_modules/.bin
MARKER=.initialized-with-makefile


$(NPM): $(NPMDEPS)
	npm install

install: bundle install

clean:
	rm -rf $$(cat .gitignore)

test-android: install
	$(NPM)/percy app:exec -- ruby tests/android.rb --verbose

test-ios: install
	$(NPM)/percy app:exec -- ruby tests/ios.rb
