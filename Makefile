install:
	bower install

run:
	brunch watch --server

server:
	npm start

build:
	brunch build --production

test:
	npm test

test-src-only:
	NODE_ENV=test ./node_modules/.bin/mocha --compilers coffee:coffee-script --require spec/spec_helper.coffee --colors --recursive -R spec spec/archaeus

.PHONY: test server build
