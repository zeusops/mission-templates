#!/bin/bash
mkdir -p compare/{missions,template}

unzip Templates\ \(A3\)*.zip
mv Templates\ \(A3\) compare/unzip
cd compare/unzip
for x in *.pbo
	do extractpbo $x
done
rm *.pbo

rm Using\ the\ templates.docx

mv Zeus_template.Altis/* ../template
mv ../template/mission.sqm Zeus_template.Altis/

find . -name *.paa -exec rm {} \;
find . -name *.jpg -exec rm {} \;
find . -name *.sqf -exec rm {} \;
find . -name *.txt -exec rm {} \;
find . -name *.ext -exec rm {} \;
find . -depth -type d -exec rmdir {} \;

mv * ../missions

rmdir ../unzip
cd ../..

diff -rw compare/template template
diff -rw compare/missions missions
