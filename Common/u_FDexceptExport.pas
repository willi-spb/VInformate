unit u_FDexceptExport;
/// модуль для MadExcept - сохранение данных отчета об ошибке в базу с заданной таблицей
/// непостредственно с ME не связан! - функция подставляется в событие внутри глобального обработчика исключений
/// задача - при подключении к БД в указанную таблицу записать параметры отчета из madExcept
/// параметры: текстовые форматированные данные отчета + картинка скрина (если есть)
///
interface

uses System.SysUtils, System.Classes,
     FireDAC.Comp.Client, FireDAC.Comp.DataSet;

/// <summary>
///    записать в базу
/// </summary>
function fee_AppendData(const AFDConn:TFDConnection; const aTablename:String; const AStr,aPngStr:TStream; var aErrStr:string):boolean;


implementation

uses Data.DB;

/////////////////////////////////////////////////////////////////////////////
/// взято из u_wMadExcept сюда
function _mExtractDatetimeFromField(const AStr:String):Tdatetime;
var LList:TStrings;
    LS:String;
 begin
   Result:=Now;
   LList:=TStringList.Create;
   try
    LList.CommaText:=Astr;
    if LList.Count=0 then exit;
    LS:=Trim(LList.Strings[0]);
    if LList.Count>1 then LS:=Concat(LS,' ',Trim(LLIst.Strings[1]));
    if LList.Count>2 then LS:=Concat(LS,',',Trim(LLIst.Strings[2]));
    Result:=StrToDateTimeDef(LS,Result);
   finally
    LList.Free;
   end;
 end;


function _DateTimeStrToMySqlDateTime(const aMadDatetime:string):string;
var LDt:Tdatetime;
  begin
    LDT:=_mExtractDatetimeFromField(aMadDatetime);
    Result:=FormatDateTime('yyyy/mm/dd hh:nn:ss',LDT);
  end;

function fee_DecodeReportFromStream(const AStr:TStream; const ADestList:TStrings):boolean;
var i,j,k:integer;
    LS:string;
 begin
   Result:=false;
   ADestList.Clear;
   ADestList.LoadFromStream(Astr);
   k:=0;
   i:=0;
   while i<ADestList.Count do
    begin
      LS:=Trim(ADestList.Strings[i]);
      if LS='' then
         break;
      j:=Pos(':',LS);
      if (j>1) and (j<Length(LS)) then
         begin
           LS[j]:='=';
           ADestList.Strings[i]:=LS; // !
           Inc(k);
         end;
      Inc(i);
    end;
   Result:=(k>19);
 end;

function fee_ConnectSQL(const ATableName:string; const AList:TStrings):string;
   function L_GetValue(const aa_Name:String; const aDefValue:string):string;
   var ii:integer;
    begin
      Result:=aDefValue;
      ii:=0;
      while ii<Alist.Count do
       begin
         if Trim(AList.Names[ii])=aa_Name then
            begin
              Result:=Trim(AList.ValueFromIndex[ii]);
              exit;
            end;
         Inc(ii);
       end;
    end;
 begin
   Result:=Format('INSERT INTO '+ATableName+' (ID,ex_date,pc_name,app_name,app_id,user_id,version,report,screen_png) '+
                             'VALUES (%d,''%s'',''%s'',''%s'',''%s'',''%s'',''%s'',:report,:screen_png);',
                             [0, _DateTimeStrToMySqlDateTime(L_GetValue('date/time','')),
                                L_GetValue('computer name','*'),
                                L_GetValue('appName','?'),
                                L_GetValue('appId','0'),
                                L_GetValue('userId','0'),
                                L_GetValue('version','0.0')]);
 end;

(*
CREATE TABLE ac01.app_bug_reports (
  ID int(11) NOT NULL AUTO_INCREMENT,
  ex_date datetime NOT NULL,
  pc_name varchar(255) DEFAULT NULL,
  app_name varchar(255) DEFAULT NULL,
  app_id int(11) UNSIGNED NOT NULL DEFAULT 0,
  user_id int(11) UNSIGNED NOT NULL DEFAULT 0,
  report text DEFAULT NULL,
  screen_png longblob DEFAULT NULL,
  version varchar(255) DEFAULT NULL,
  PRIMARY KEY (ID)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 49152
CHARACTER SET utf8
COLLATE utf8_general_ci
COMMENT = 'bug reports of ARM';
*)


function fee_AppendData(const AFDConn:TFDConnection; const aTablename:String;
                       const AStr,aPngStr:TStream; var aErrStr:string):boolean;
var LFQ:TFDQuery;
    LList:TStrings;
    Lname,LSQL:string;
 begin
   Result:=false;
   aErrStr:='';
   if AFDConn.Connected=false then
     begin
      // aErrStr:='E_ConnnectError=fee_AppendData Not Connected to base!';
       exit;
     end;
    LFQ:=TFDQuery.Create(nil);
    LList:=TStringList.Create;
    try
     if fee_DecodeReportFromStream(Astr,LList)=false then exit;
     ///
     if aTablename='' then
        Lname:='app_bug_reports'
     else Lname:=Trim(aTablename);
     LSQL:=fee_ConnectSQL(Lname,LList);
     ///
     LFQ.Connection:=AFDConn;
     LFQ.SQL.Clear;
     LFQ.Params.Clear;
     LFQ.SQL.Add(LSQL);
     try
      // LFQ.Params[0].LoadFromStream(AStr,ftblob);
      // LFQ.Params[1].LoadFromStream(aPngStr,ftblob);
       LFQ.Params.ParamByName('report').LoadFromStream(AStr,ftblob);
       LFQ.Params.ParamByName('screen_png').LoadFromStream(aPngStr,ftblob);
       ///
       LFQ.ExecSQL;
       Result:=true;
      except
       on E:Exception do
          aErrStr:=Concat(E.ClassName,'=',E.Message);
     end;
     ///
    finally
      LFQ.Free;
      LList.free;
    end;
 end;


end.
