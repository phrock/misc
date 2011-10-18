RPMBUILD="${HOME}/rpmbuild"
SPECFILE=`ls *.spec`

cp -v -f ${SPECFILE} ${RPMBUILD}/SPECS/
for i in *; do
    if [ ${i} != ${SPECFILE} ]; then
        cp -v -f ${i} ${RPMBUILD}/SOURCES/
    fi
done

rpmbuild -bp ${RPMBUILD}/SPECS/${SPECFILE}


if [ $? = 0 ]; then
    echo
    echo "rpmbuild -bp ${RPMBUILD}/SPECS/${SPECFILE}"
    echo
fi
