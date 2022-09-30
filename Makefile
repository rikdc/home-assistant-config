EXPORT_RESULT?=false

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

lint:
	docker run --rm -v "$(shell pwd):/work" tmknom/prettier --parser=yaml --check '{automation,binary_sensor,scripts,sensors,group,templates,configuration}/**/*.y*ml'

format-yaml:
	docker run --rm -v "$(shell pwd):/work" tmknom/prettier --parser=yaml --write '{automation,binary_sensor,scripts,sensors,group,templates,configuration}/**/*.y*ml'
