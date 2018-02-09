unit u_getwmInfo;
///
///  получение информации о жестком диске ПК
///  (отдельно получение в виде строки серийного номера HDD)
///
///  Вним! - иcпользуется вызов возможностей WMI-системы -
///  в XP<sp2  может не работать!
///
interface

/// <summary>
///    получить строку с набором параметров по запросу о HDD
/// </summary>
 function getWMInfo(rg:integer; var aInfoStr:string):boolean;
/// <summary>
///    получить серийный номер HDD строки
/// </summary>
 function get_WMInfoSNumString:string;


implementation

uses  Classes, SysUtils, variants,
      ActiveX,
      ComObj;

 var
      FSWbemLocator : OLEVariant;
      FWMIService   : OLEVariant;

    function GetWMIstring(const WMIClass, WMIProperty:string): string;
    const
      wbemFlagForwardOnly = $00000020;
    var
      FWbemObjectSet: OLEVariant;
      FWbemObject   : OLEVariant;
      oEnum         : IEnumvariant;
      iValue        : LongWord;
    begin;
      Result:='';
      FWbemObjectSet:= FWMIService.ExecQuery(Format('Select %s from %s',[WMIProperty, WMIClass]),'WQL',wbemFlagForwardOnly);
      oEnum         := IUnknown(FWbemObjectSet._NewEnum) as IEnumVariant;
      if oEnum.Next(1, FWbemObject, iValue) = 0 then

  if not VarIsNull(FWbemObject.Properties_.Item(WMIProperty).Value) then

     Result:=FWbemObject.Properties_.Item(WMIProperty).Value;

    FWbemObject:=Unassigned;
    end;

function getWMInfo(rg:integer; var aInfoStr:string):boolean;
 var LList:TStringList;
 begin
   Result:=false;
   FSWbemLocator := CreateOleObject('WbemScripting.SWbemLocator');
   FWMIService   := FSWbemLocator.ConnectServer('localhost', 'root\CIMV2', '', '');
   LList:=TStringList.Create;
   try
    LList.Add('bios='+Trim(GetWMIstring('Win32_BIOS','SerialNumber')));
    LList.Add('media='+Trim(GetWMIstring('Win32_PhysicalMedia','SerialNumber')));
    LList.Add('disk='+Trim(GetWMIstring('Win32_DiskDrive','SerialNumber')));
    Result:=(LList.Count>2);
    if Result then
       aInfoStr:=LList.CommaText;
   finally
     LList.Free;
   end;
 end;

function Get_WMInfoSNumString:string;
var LS:String;
    LList:TStringList;
    i:integer;
begin
  Result:='';
  if getWMInfo(0,LS) then
   begin
     LList:=TStringList.Create;
     try
       LList.CommaText:=LS;
       i:=LList.Count-1;
       while i>=1 do
         begin
           Result:=LList.ValueFromIndex[i];
           if Result<>'' then
              break;
           Dec(i);
         end;
     finally
       LList.Free;
     end;
   end;
end;


end.
