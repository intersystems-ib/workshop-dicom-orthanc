ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community:2023.1.0.218.0
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown -R irisowner:irisowner /opt/irisapp

# RUN mkdir /usr/irissys/mgr/DICOMDB
# RUN chown -R irisowner:irisowner /usr/irissys/mgr/DICOMDB

USER irisowner

# copy files to image
WORKDIR /opt/irisapp
#COPY --chown=irisowner:irisowner /iris/iris.script iris.script
COPY --chown=irisowner:irisowner src src

COPY --chown=$ISC_PACKAGE_MGRUSER:$ISC_PACKAGE_IRISGROUP /iris/irissession.sh /
RUN chmod +x /irissession.sh

SHELL ["/irissession.sh"]

RUN \
  zn "%SYS" \
  set sc = $SYSTEM.OBJ.LoadDir("/opt/irisapp/src/Test", "ck", , 1) \
  if sc do ##class(DICOM.Installer).Install() \
  # DICOM connection creation
  zn "DICOM" \
  set sc = $SYSTEM.OBJ.LoadDir("/opt/irisapp/src/Production", "ck", , 1) \
  Do ##class(EnsLib.DICOM.Util.AssociationContext).CreateAssociation("IRIS","ORTHANC",) \
  Do ##class(EnsLib.DICOM.Util.AssociationContext).CreateAssociation("ORTHANC","IRIS") \
  Do ##class(EnsLib.DICOM.Util.AssociationContext).ImportAssociation("/opt/irisapp/src/DICOM/associations.txt","IRIS","ORTHANC",0) \
  Do ##class(EnsLib.DICOM.Util.AssociationContext).ImportAssociation("/opt/irisapp/src/DICOM/associations.txt","ORTHANC","IRIS",0) \
  # start production
  set production = "DICOMPKG.FoundationProduction" \
  set ^Ens.Configuration("csp","LastProduction") = production \
  do ##class(Ens.Director).SetAutoStart(production) \
  set sc = 1

# run iris.script
# RUN iris start IRIS \
#   && iris session IRIS < /opt/irisapp/iris.script \
#   && iris stop IRIS quietly