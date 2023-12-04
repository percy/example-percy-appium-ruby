NPM=node_modules/.bin
MARKER=.initialized-with-makefile


$(NPM): $(NPMDEPS)
	npm install

install: bundle
	bundle install

bundle:

clean:
	rm -rf $$(cat .gitignore)

test-android:
	$(NPM)/percy app:exec -- ruby tests/android.rb --verbose

test-ios:
	$(NPM)/percy app:exec -- ruby tests/ios.rb
