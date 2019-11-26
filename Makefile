local_token = ${LOCAL_TOKEN}
production_token = ${PRODUCTION_TOKEN}

test:
	rm coverage.xml || true
	rm .coverage || true
	python -m pytest --cov=./

test.flagone:
	rm coverage.xml || true
	rm .coverage || true
	python -m pytest --cov=./ tests/test_number_two.py

local.report:
	./local.sh -t ${local_token} -F flagsecond -parent 17a71a9a2f5335ed4d00496c7bbc6405f547a527

local.report.flagone:
	./local.sh -t ${local_token} -F flagone -parent 17a71a9a2f5335ed4d00496c7bbc6405f547a527

production.report:
	./production.sh -t ${production_token} -F flagproduction

show_vars:
	echo ${local_token}
	echo ${production_token}

local.full:
	${MAKE} local.download
	${MAKE} test
	${MAKE} local.report
	${MAKE} test.flagone
	${MAKE} local.report.flagone

production.full:
	${MAKE} production.download
	${MAKE} test
	${MAKE} production.report

local.download:
	curl -s http://localhost/bash > local.sh
	chmod +x ./local.sh

production.download:
	curl -s https://codecov.io/bash > production.sh
	chmod +x ./production.sh