#!/bin/bash
echo ::
	echo Running as Bash CMD FakeMake ;
	pwd ;
	cd  $(dirname $0) ;  \
	execution=`egrep  -h -A100 ^$1:    $(dirname $0)/./Makefile  |  egrep -v ^$1:  | grep -m 1  -h  -B100 :  | grep -m 1  -h  -B100 \t |    sed -E  's/[$][{](.+)[}]/$\1/g' | sed -E 's/[$]{2}/$/g' ` ; \
	echo "Command to Execute @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";  \
	echo "$execution" ; \
	echo "Execution @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";   \
	echo "$execution" >  /tmp/test.sh ;  \
	bash  /tmp/test.sh ;   \
	echo "Execution DONE@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" ; \
	exit 0;

help::
	@if [ "${t}" = "" ] ; then \
		grep -E "^[a-zA-Z0-9_ ]+[:]+" Makefile   | awk -F":" '{print $$1}'   ; \
	else \
		grep -E "^[a-zA-Z0-9_ ]+[:]+" Makefile   | grep -i "${t}"  | tr ";:\043" " " ;  \
	fi;

unitestenv::
	pdk --version
	cat .fixtures.yml

unitest: unitestenv
	pdk test unit

unittestverbose: unitestenv
	pdk test unit -v

unittest_puppet5_5: unitestenv
	pdk test unit   --puppet-version=5.5.21

unittestverbose_puppet5_5: unitestenv
	pdk test unit -v   --puppet-version=5.5.21




usechocolatey_NEW:
	cp -f ./fixtures.yml_NEW .fixtures.yml	

usechocolatey_ORG:
	cp -f ./fixtures.yml_OLD .fixtures.yml	

usechocolatey_MODDED:
	cp -f ./fixtures.yml_NEWMODDED .fixtures.yml	

	
	
usechocolateyDefaultFacts_ORG:
	cp -f spec/default_facts.yml_ORG spec/default_facts.yml

usechocolateyDefaultFacts_MODDED:
	cp -f spec/default_facts.yml_MODDED spec/default_facts.yml
	