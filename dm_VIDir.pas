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
  end;

var
  VD_DM: TVD_DM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TVD_DM.ConnectTobase: boolean;
begin
  Result:=false;
   conLite.Connected:=true;
  ///
  FDT_Users.Active:=true;
  FDT_works.Active:=true;
  FDT_Tasks.Active:=true;
  Result:=true;
end;

end.
