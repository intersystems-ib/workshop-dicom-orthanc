Class Demo.DICOM.FoundationProduction Extends Ens.Production [ Not ProcedureBlock ]
{

Parameter SETTINGS = "ShutdownTimeout,UpdateTimeout,StorageLocation";

Property StorageLocation As %String;

XData ProductionDefinition
{
<Production Name="Demo.DICOM.FoundationProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Setting Target="Adapter" Name="StorageLocation">/shared/durable/out</Setting>
  <Item Name="EnsLib.DICOM.Service.File" Category="" ClassName="EnsLib.DICOM.Service.File" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/shared/durable/in/</Setting>
    <Setting Target="Host" Name="TargetConfigName">Demo.DICOM.Process.StorageFile</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.dcm</Setting>
  </Item>
  <Item Name="Demo.DICOM.Process.StorageFile" Category="" ClassName="Demo.DICOM.Process.StorageFile" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="OperationDuplexName">EnsLib.DICOM.Operation.TCP</Setting>
    <Setting Target="Host" Name="StorageLocation">/shared/durable/out</Setting>
  </Item>
  <Item Name="EnsLib.DICOM.Operation.TCP" Category="" ClassName="EnsLib.DICOM.Operation.TCP" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="IPAddress">orthanc</Setting>
    <Setting Target="Adapter" Name="IPPort">4242</Setting>
    <Setting Target="Adapter" Name="LocalAET">IRIS</Setting>
    <Setting Target="Adapter" Name="RemoteAET">ORTHANC</Setting>
    <Setting Target="Host" Name="DuplexTargetConfigName">Demo.DICOM.Process.StorageFile</Setting>
    <Setting Target="Adapter" Name="TraceVerbosity">2</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Adapter" Name="SSLConfig">ORTHANC_TLS</Setting>
  </Item>
  <Item Name="EnsLib.DICOM.Service.TCP" Category="" ClassName="EnsLib.DICOM.Service.TCP" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="IPPort">2010</Setting>
    <Setting Target="Adapter" Name="LocalAET">IRIS</Setting>
    <Setting Target="Adapter" Name="RemoteAET">ORTHANC</Setting>
    <Setting Target="Host" Name="DuplexTargetConfigName">Demo.DICOM.Process.StorageLocal</Setting>
    <Setting Target="Adapter" Name="TraceVerbosity">2</Setting>
  </Item>
  <Item Name="Demo.DICOM.Operation.File" Category="" ClassName="Demo.DICOM.Operation.File" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="FileStorageDirectory">/shared/durable/repository</Setting>
  </Item>
  <Item Name="Demo.DICOM.Process.StorageLocal" Category="" ClassName="Demo.DICOM.Process.StorageLocal" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
