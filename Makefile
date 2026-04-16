# /dartpedia/Makefile

.PHONY: get dcli

# Run pub get for all projects
get:
	dart pub get -C cli
	dart pub get -C command_runner

dcli:
	dart run cli/bin/cli.dart $(args)

