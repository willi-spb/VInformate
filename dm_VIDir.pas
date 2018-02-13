unit dm_VIDir;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TVD_DM = class(TDataModule)
    conLite: TFDConnection;
    FDT_Users: TFDTable;
    FDT_works: TFDTable;
    FDT_Tasks: TFDTable;
    FDT_UsersID: TFDAutoIncField;
    FDT_UsersNAME: TWideStringField;
    FDT_UsersU_INFO: TWideStringField;
    FDT_UsersCONTACTS: TWideStringField;
    FDT_UsersCOMMENTARY: TWideStringField;
    FDT_UsersGROUP_ID: TIntegerField;
    FDT_UsersSIGN: TIntegerField;
    FDT_UsersU_DATE: TDateTimeField;
    FDT_UsersCATALOG: TWideStringField;
    FDT_worksID: TFDAutoIncField;
    FDT_worksINFO: TWideStringField;
    FDT_worksB_DATE: TDateTimeField;
    FDT_worksE_DATE: TDateTimeField;
    FDT_worksCOMMENTARY: TWideStringField;
    FDT_worksSTATE: TIntegerField;
    FDT_worksSIGN: TIntegerField;
    FDT_worksCATALOG: TWideStringField;
    FDT_TasksID: TFDAutoIncField;
    FDT_TasksWORK_ID: TIntegerField;
    FDT_TasksUSER_ID: TIntegerField;
    FDT_TasksB_DATE: TDateTimeField;
    FDT_TasksE_DATE: TDateTimeField;
    FDT_TasksNAME: TWideStringField;
    FDT_TasksU_REMARKS: TWideStringField;
    FDT_TasksU_GRAPH: TBlobField;
    FDT_TasksCATALOG: TWideStringField;
    FDT_TasksCOMMENTARY: TWideStringField;
    FDT_TasksGROUP_ID: TIntegerField;
    FDT_TasksGRAPH: TBlobField;
    FDT_TasksSTATE: TIntegerField;
    FDT_TasksSIGN: TIntegerField;
    dsUsers: TDataSource;
    dsWorks: TDataSource;
    FDT_worksUSER_ID: TIntegerField;
    FDT_worksPRICE: TIntegerField;
    FDT_worksPAID: TIntegerField;
    FDT_TasksPRICE: TIntegerField;
    FDT_TasksPAID: TIntegerField;
    FDT_worksPD_DATE: TDateTimeField;
    FDT_TasksPD_DATE: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
    function ConnectTobase:boolean;
    function PrepareTasksReport(arg:integer; const aRList:TStrings):Boolean;
  end;

var
  VD_DM: TVD_DM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TVD_DM.ConnectTobase: boolean;
begin
  Result:=false;
  //
  conLite.Params.Database:='../../Resource/dataLite.sdb';

   conLite.Connected:=true;
  ///
  FDT_Users.Active:=true;
  FDT_works.Active:=true;
  FDT_Tasks.Active:=true;
  Result:=true;
end;


function Get_StateDesc(aState:Integer):string;
 begin
   case aState of
    0: Result:='Оговорена';
    1: Result:='В работе';
    2: Result:='Отменена';
    3: Result:='Выполнена';
    4: Result:='Закрыта с оплатой';
    else Result:=IntToStr(aState);
   end;
 end;

function TVD_DM.PrepareTasksReport(arg: integer;
  const aRList: TStrings): Boolean;
 var LPrice,LPaid:Integer;
     L_CurrDate:TDateTime;
     L_State:integer;
     i,LK,jj,kk:Integer;
    LS,LS1:string;
begin
  L_CurrDate:=Now;
  FDT_Tasks.DisableControls;
  try
   LPrice:=0; LPaid:=0;
   ///
   aRList.Add(Concat('       Отчет по работам от '+DateTimeToStr(L_CurrDate)));
   aRList.Add(Concat('Заказчик: ',FDT_Users.FieldByName('NAME').AsWideString));
   aRList.Add(Concat('Задание: ',FDT_works.FieldByName('INFO').AsWideString));
   aRList.Add(Concat('Сроки: от ',DateToStr(FDT_works.FieldByName('B_DATE').AsDateTime)));
   aRList.Add('---');
   ///
   FDT_Tasks.First;
   i:=1;  jj:=0; kk:=0;
   while not(FDT_Tasks.Eof) do
   with FDT_Tasks do
    begin
      if i=1 then
         aRList.Add('Перечень работ: ');
      L_State:=1;
      if FieldByName('E_DATE').AsDateTime<=L_CurrDate then
        begin
          L_State:=3;
          if FieldByName('PAID').AsInteger>=FieldByName('PRICE').AsInteger then
             L_State:=4;
       end;
      LPrice:=LPrice+FieldByName('PRICE').AsInteger;
      LPaid:=LPaid+FieldByName('PAID').AsInteger;
      if (FieldByName('STATE').IsNull) or (FieldByName('STATE').AsInteger<10) then
        begin
         FDT_Tasks.Edit;
         FDT_Tasks.FieldByName('STATE').AsInteger:=L_State;
         if L_State=3 then
            Inc(jj);
         if L_State=4 then
            Inc(kk);
         FDT_Tasks.Post;
        end;
      ///
      if (FieldByName('U_REMARKS').IsNull=false) then
         LS:=' ('+FieldByName('U_REMARKS').AsWideString+')'
      else LS:='';
      if (FieldByName('PAID').AsInteger>0) and (FieldByName('PD_DATE').IsNull=False) then
         LS1:=' Дата оплаты: '+DateToStr(FieldByName('PD_DATE').AsDateTime)
      else LS1:='';
      aRList.Add(Concat(' ',IntToStr(i),'. ',FieldByName('NAME').AsWideString,' Сроки: от ',
                DateToStr(FieldByName('B_DATE').AsDateTime),' по ',
                DateToStr(FieldByName('E_DATE').AsDateTime),
                LS));
      if arg>=1 then
        aRList.Add(Concat(' ','   ','<<',Get_StateDesc(L_State),'>>',' стоимость:',
                 IntToStr(FieldByName('PRICE').AsInteger),'  руб., оплачено: ',
                 IntToStr(FieldByName('PAID').AsInteger),'  руб.',
                 LS1))
      else
       aRList.Add(Concat(' ','   ','<<',Get_StateDesc(L_State),'>>'));
     // aRList.Add('-*-');
      ///
      FDT_Tasks.Next;
      Inc(i);
    end;
   if i>0 then Dec(i);
   aRList.Add(Format(' Описано заданий: %d, из них выполнено: %d, закрыто: %d',[i,jj,kk]));
   if arg>=1 then
    begin
     aRList.Add(' Итого, по выполненным заданиям:');
     if LPrice>Lpaid then
        LK:=LPrice-Lpaid
      else LK:=0;
      aRList.Add(Format('стоимость: %d руб., оплачено: %d руб.  К ОПЛАТЕ: %d руб.',
                    [LPrice,LPaid,LK]));
      if LK=0 then
        aRList.Add('Задание закрыто!');
    end;
   ///
   ///
  finally
    FDT_Tasks.EnableControls;
  end;
end;

end.
