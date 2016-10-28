clear
git checkout .
echo "Running"
unset all
unset vol
unset no
unset ed
unset par
unset se
all=all_files.txt
vol=volume.txt
no=no.txt
ed=edition.txt
par=part.txt
se=series.txt
rm all_files.txt volume.txt no.txt edition.txt part.txt
# mkfifo $all
# mkfifo $vol
# mkfifo $ed
find . -name dublin_core.xml > $all
echo 'Num files to process'

(cat $all | xargs  ack-grep -li '[. _,-]+no[. _,-]+' > $no) 
(cat $all | xargs  ack-grep -li '(ed(ition)?)' > $ed) 
(cat $all | xargs  ack-grep -li '(vol(ume)?)' > $vol) 
(cat $all | xargs  ack-grep -li '(p(ar)?t)' > $par) 
(cat $all | xargs  ack-grep -li '(vol(ume)?)' > $vol) 
# (echo './121040/dublin_core.xml' > $se)
wait

echo 'written to files'

cat $no | xargs  perl -pi -e 's/[. _,-]+no[. _,-]+([0-9]+)/ No \1 /gi'

#normal
cat $vol | xargs  perl -pi -e 's/(vol(ume)?)([. _-]*)([0-9]+)([._,-]*[0-9]+)?(.*)(<\/dcvalue>)/\6 Volume \4\5\7/gi' # working ;)
cat $ed | xargs  perl -pi -e 's/(ed(ition)?)([. _-]*)([0-9]+)([._,-]*[0-9]+)?(.*)(<\/dcvalue>)/\6 Edition \4\5\7/gi' # working ?
cat $par | xargs  perl -pi -e 's/(p(ar)?t)([. _-]*)([0-9]+)([._,-]*[0-9]+)?(.*)(<\/dcvalue>)/\6 Part \4\5\7/gi' # working ?
cat $se | xargs  perl -pi -e 's/(serie(s))([. _-]*)([0-9]+)([._,-]*[0-9]+)?(.*)(<\/dcvalue>)/\6 Series \4\5\7/gi' # working ;)

# #ROMAN NUMERALS
# cat all_files | xargs  perl -pi -e 's/ vol(ume)?[._ -]\{1,3\}([cxvi]+)(.*)(<\/dcvalue)/\3 Volume \2\4/gi'
# cat all_files | xargs  perl -pi -e 's/ ed(ition)?[._ -]\{1,3\}([cxvi]+)(?\![a-z])(.*)(<\/dcvalue)/ \3 Edition ;) \2\4/gi'
# cat all_files | xargs  perl -pi -e 's/ p(ar)?t[._ -]\{1,3\}([cxvi]+)(.*)(<\/dcvalue)/\3 Part \2\4/gi'
# cat all_files | xargs  perl -pi -e 's/ serie(s)?[._ -]\{1,3\}([cxvi]+)(.*)(<\/dcvalue)/\3 Series \2\4/gi'

#ROMAN2
cat $ed | xargs  perl -pi -e 's/[._ ()-]ed(ition)?[._ -]{1,3}([cxvi]+)(?![a-z])(.*)(<\/dcvalue>)/\3 Edition \U\2\E\4/gi'
cat $vol | xargs  perl -pi -e 's/[._ ()-]vol(ume)?[._ -]{1,3}([cxvi]+)(?![a-z])(.*)(<\/dcvalue>)/\3 Volume \U\2\E\4/gi'
cat $par | xargs  perl -pi -e 's/[._ ()-]p(ar)?t[._ -]{1,3}([cxvi]+)(?![a-z])(.*)(<\/dcvalue>)/\3 Part \U\2\E\4/gi'
cat $se | xargs  perl -pi -e 's/[._ ()-]serie(s)?[._ -]{1,3}([cxvi]+)(?![a-z])(.*)(<\/dcvalue>)/\3 Series \U\2\E\4/gi'

#alphabetic

cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+one(.*)(<\/dcvalue>)/\2 Volume 1\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+two(.*)(<\/dcvalue>)/\2 Volume 2\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+three(.*)(<\/dcvalue>)/\2 Volume 3\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+four(.*)(<\/dcvalue>)/\2 Volume 4\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+five(.*)(<\/dcvalue>)/\2 Volume 5\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+six(.*)(<\/dcvalue>)/\2 Volume 6\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+seven(.*)(<\/dcvalue>)/\2 Volume 7\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+eight(.*)(<\/dcvalue>)/\2 Volume 8\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+nine(.*)(<\/dcvalue>)/\2 Volume 9\3/ig'
cat $vol | xargs  perl -pi -e 's/vol(ume)?[._ ()-]+ten(.*)(<\/dcvalue>)/\2 Volume 10\3/ig'

cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+one(.*)(<\/dcvalue>)/\2 Part 1\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+two(.*)(<\/dcvalue>)/\2 Part 2\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+three(.*)(<\/dcvalue>)/\2 Part 3\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+four(.*)(<\/dcvalue>)/\2 Part 4\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+five(.*)(<\/dcvalue>)/\2 Part 5\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+six(.*)(<\/dcvalue>)/\2 Part 6\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+seven(.*)(<\/dcvalue>)/\2 Part 7\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+eight(.*)(<\/dcvalue>)/\2 Part 8\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+nine(.*)(<\/dcvalue>)/\2 Part 9\3/ig'
cat $par | xargs  perl -pi -e 's/p(ar)?t[._ ()-]+ten(.*)(<\/dcvalue>)/\2 Part 10\3/ig'


cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+one(.*)(<\/dcvalue>)/\2 Edition 1\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+two(.*)(<\/dcvalue>)/\2 Edition 2\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+three(.*)(<\/dcvalue>)/\2 Edition 3\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+four(.*)(<\/dcvalue>)/\2 Edition 4\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+five(.*)(<\/dcvalue>)/\2 Edition 5\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+six(.*)(<\/dcvalue>)/\2 Edition 6\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+seven(.*)(<\/dcvalue>)/\2 Edition 7\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+eight(.*)(<\/dcvalue>)/\2 Edition 8\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+nine(.*)(<\/dcvalue>)/\2 Edition 9\3/ig'
cat $ed | xargs  perl -pi -e 's/ed(ition)?[._ ()-]+ten(.*)(<\/dcvalue>)/\2 Edition 10\3/ig'


cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+one(.*)(<\/dcvalue>)/\2 Series 1\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+two(.*)(<\/dcvalue>)/\2 Series 2\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+three(.*)(<\/dcvalue>)/\2 Series 3\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+four(.*)(<\/dcvalue>)/\2 Series 4\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+five(.*)(<\/dcvalue>)/\2 Series 5\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+six(.*)(<\/dcvalue>)/\2 Series 6\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+seven(.*)(<\/dcvalue>)/\2 Series 7\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+eight(.*)(<\/dcvalue>)/\2 Series 8\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+nine(.*)(<\/dcvalue>)/\2 Series 9\3/ig'
cat $se | xargs  perl -pi -e 's/serie(s)?[._ ()-]+ten(.*)(<\/dcvalue>)/\2 Series 10\3/ig'

#alphabetic2
cat $vol | xargs  perl -pi -e 's/first[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 1\3/gi'
cat $vol | xargs  perl -pi -e 's/second[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 2\3/gi'
cat $vol | xargs  perl -pi -e 's/third[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 3\3/gi'
cat $vol | xargs  perl -pi -e 's/fourth[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 4\3/gi'
cat $vol | xargs  perl -pi -e 's/fifth[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 5\3/gi'
cat $vol | xargs  perl -pi -e 's/sixth[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 6\3/gi'
cat $vol | xargs  perl -pi -e 's/seventh[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 7\3/gi'
cat $vol | xargs  perl -pi -e 's/eight[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 8\3/gi'
cat $vol | xargs  perl -pi -e 's/ninth[._ ()-]+vol(ume)?(.*)(<\/dcvalue>)/\2 Volume 9\3/gi'

cat $ed | xargs  perl -pi -e 's/first[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 1\3/gi'
cat $ed | xargs  perl -pi -e 's/second[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 2\3/gi'
cat $ed | xargs  perl -pi -e 's/third[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 3\3/gi'
cat $ed | xargs  perl -pi -e 's/fourth[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 4\3/gi'
cat $ed | xargs  perl -pi -e 's/fifth[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 5\3/gi'
cat $ed | xargs  perl -pi -e 's/sixth[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 6\3/gi'
cat $ed | xargs  perl -pi -e 's/seventh[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 7\3/gi'
cat $ed | xargs  perl -pi -e 's/eight[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 8\3/gi'
cat $ed | xargs  perl -pi -e 's/ninth[._ ()-]+ed(ition)?(.*)(<\/dcvalue>)/\2 Edition 9\3/gi'

cat $par | xargs  perl -pi -e 's/first[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 1\3/gi'
cat $par | xargs  perl -pi -e 's/second[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 2\3/gi'
cat $par | xargs  perl -pi -e 's/third[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 3\3/gi'
cat $par | xargs  perl -pi -e 's/fourth[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 4\3/gi'
cat $par | xargs  perl -pi -e 's/fifth[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 5\3/gi'
cat $par | xargs  perl -pi -e 's/sixth[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 6\3/gi'
cat $par | xargs  perl -pi -e 's/seventh[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 7\3/gi'
cat $par | xargs  perl -pi -e 's/eight[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 8\3/gi'
cat $par | xargs  perl -pi -e 's/ninth[._ ()-]+p(ar)?t(.*)(<\/dcvalue>)/\2 Part 9\3/gi'

cat $se | xargs  perl -pi -e 's/first[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 1\3/gi'
cat $se | xargs  perl -pi -e 's/second[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 2\3/gi'
cat $se | xargs  perl -pi -e 's/third[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 3\3/gi'
cat $se | xargs  perl -pi -e 's/fourth[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 4\3/gi'
cat $se | xargs  perl -pi -e 's/fifth[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 5\3/gi'
cat $se | xargs  perl -pi -e 's/sixth[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 6\3/gi'
cat $se | xargs  perl -pi -e 's/seventh[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 7\3/gi'
cat $se | xargs  perl -pi -e 's/eight[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 8\3/gi'
cat $se | xargs  perl -pi -e 's/ninth[._ ()-]+serie(s)(.*)(<\/dcvalue>)/\2 Series 9\3/gi'

# cat all_files | xargs  perl -pi -e 's/(vol(ume)*)([. _-]*)([0-9])+([._,-]*[0-9]+)?(.*)(<\/dcvalue>)/\& 01=\1 2=\2 3=\3 4=\4 5=\5 6=\6 7=\7 8=\8 9=\9/gi'

# #others
cat all_files | xargs  perl -pi -e 's/ltd[.,-]*/Limited/gi'
# #1 remove HTML tags &amp; \n \
cat all_files | xargs  perl -pi -e 's/&amp;?/and/gi'
# #2 remove empty ()
# #3 remove '  ' -> ' '
cat all_files | xargs  perl -pi -e 's/\([ ,_-]*\)/ /gi'
cat all_files | xargs  perl -pi -e 's/  +/ /gi'

# #Govt.
cat all_files | xargs  perl -pi -e 's/govt[., ]+/Government /gi'
# #(01=Vol 2= 3=.  4=5 5=-8 6= blah 7=<\/dcvalue> )
# #Editon -> Edition

# # cat all_files | xargs  perl -pi -e 's/(vol(ume)*)([. _-]*)([0-9]+)([._,-]*[0-9]+)?(.*)(<\/dcvalue>)/ == 1=\1 2=\2 3=\3 4=\4 5=\5 6=\6 7=\7 ==/gi'
cat all_files | xargs  perl -pi -e 's/ <\/dcvalue>/<\/dcvalue>/gi'
# # find . -name *core.xml | xargs  
# # volume no. <<<


echo Done
unset all
unset vol
unset no
unset ed
unset par
unset se
