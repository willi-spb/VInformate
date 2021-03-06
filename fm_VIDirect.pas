﻿unit fm_VIDirect;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.DB, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.TabControl, dm_VIDir, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.StdCtrls, FMX.Memo, FMX.Edit,
  FMX.DateTimeCtrls, System.Actions, FMX.ActnList, Data.Bind.Controls,
  FMX.Layouts, Fmx.Bind.Navigator, FMX.ExtCtrls, FMX.EditBox, FMX.NumberBox;

type
  TVIDirectForm = class(TForm)
    tbc_D: TTabControl;
    tiUsers: TTabItem;
    tiWorks: TTabItem;
    GridUsers: TGrid;
    BindSourceDB_Users: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    pnl_UData: TPanel;
    mmo_UComment: TMemo;
    lbl_Desc_UComment: TLabel;
    LinkPropertyToFieldLinesText: TLinkPropertyToField;
    edt_UContacts: TEdit;
    lbl_UContacts: TLabel;
    edt_UCatalog: TEdit;
    lbl_UCatalog: TLabel;
    mmo_UserInfo: TMemo;
    lbl_UInfo: TLabel;
    dt_User1: TDateEdit;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    tiTasks: TTabItem;
    Panel1: TPanel;
    mmo_WCommentary: TMemo;
    lbl_WCommentary: TLabel;
    edt_WCatalog: TEdit;
    lbl_WCatalog: TLabel;
    mmo_WInfo: TMemo;
    lbl_WInformation: TLabel;
    dt_WBegin: TDateEdit;
    GridWorks: TGrid;
    BindSourceDB_works: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB12: TLinkGridToDataSource;
    dt_WEnd: TDateEdit;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    Panel2: TPanel;
    mmo_TCommentary: TMemo;
    lbl_TCommentary: TLabel;
    lbl_TGraph: TLabel;
    mmo_TRemarks: TMemo;
    lbl_TRemarks: TLabel;
    dt_TBegin: TDateEdit;
    dt_TEnd: TDateEdit;
    GridTasks: TGrid;
    img_Graph: TImageControl;
    BindSourceDB_tasks: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    LinkControlToField10: TLinkControlToField;
    LinkControlToField11: TLinkControlToField;
    LinkControlToField12: TLinkControlToField;
    LinkControlToField13: TLinkControlToField;
    LinkControlToField14: TLinkControlToField;
    pnl_UTop: TPanel;
    btnAddUser: TButton;
    aLST: TActionList;
    actAddUser: TAction;
    actReopenTables: TAction;
    actDeleteUser: TAction;
    actAddWork: TAction;
    pnl_WorksTop: TPanel;
    Button2: TButton;
    actDeleteWork: TAction;
    pnl_TasksTop: TPanel;
    Button4: TButton;
    actAddTask: TAction;
    actDeleteTask: TAction;
    NavigatorBindSourceDB_tasks: TBindNavigator;
    NavigatorBindSourceDB_Users: TBindNavigator;
    NavigatorBindSourceDB_works: TBindNavigator;
    img_TU_Graph: TImageControl;
    lbl_TUGraph: TLabel;
    LinkControlToField15: TLinkControlToField;
    nmbrbx_WPrice: TNumberBox;
    lbl_WPrice: TLabel;
    nmbrbx_WPaid: TNumberBox;
    lbl_WPaid: TLabel;
    nmbrbx_TPaid: TNumberBox;
    lbl_TPaid: TLabel;
    lbl_TPrice: TLabel;
    nmbrbx_TPrice: TNumberBox;
    dt_TPD: TDateEdit;
    dt_WPD: TDateEdit;
    LinkControlToField16: TLinkControlToField;
    LinkControlToField17: TLinkControlToField;
    LinkControlToField18: TLinkControlToField;
    LinkControlToField19: TLinkControlToField;
    LinkControlToField20: TLinkControlToField;
    LinkControlToField21: TLinkControlToField;
    btn_TClearUGraph: TButton;
    btn_TClearGraph: TButton;
    btn_WSelDir: TButton;
    btn_TSelectDir: TButton;
    btn1: TButton;
    btnOpenExp: TButton;
    btn2: TButton;
    actTasksReport: TAction;
    chk_TReport: TCheckBox;
    pnl1: TPanel;
    grd1: TGrid;
    BindSourceDB1: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB13: TLinkGridToDataSource;
    ImageControl1: TImageControl;
    LinkControlToField22: TLinkControlToField;
    procedure FormCreate(Sender: TObject);
    procedure actReopenTablesExecute(Sender: TObject);
    procedure actAddUserExecute(Sender: TObject);
    procedure actDeleteUserUpdate(Sender: TObject);
    procedure actDeleteUserExecute(Sender: TObject);
    procedure actAddWorkExecute(Sender: TObject);
    procedure actDeleteWorkUpdate(Sender: TObject);
    procedure actDeleteWorkExecute(Sender: TObject);
    procedure actDeleteTaskUpdate(Sender: TObject);
    procedure actDeleteTaskExecute(Sender: TObject);
    procedure actAddTaskExecute(Sender: TObject);
    procedure img_GraphLoaded(Sender: TObject; const FileName: string);
    procedure btn_TClearUGraphClick(Sender: TObject);
    procedure btn_WSelDirClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnOpenExpClick(Sender: TObject);
    procedure actTasksReportExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDefPath:string;
  public
    { Public declarations }
    function LocateFromIni(aLocRg:integer):Boolean;
    function SaveToIni:Boolean;
    function ClearBlobData(const ADS:TDataset; const aFieldName:string):boolean;
    function FillCatalogData(const ADS:TDataset; const aFieldName:string):boolean;
  end;

var
  VIDirectForm: TVIDirectForm;

implementation

{$R *.fmx}

uses wAppEnviron,
     DateUtils,
     {$IFDEF MSWINDOWS}
     FMX.Platform.Win,
     ShellApi,
     {$ENDIF}
     dm_VIReports,
     fm_Image,
     dlg_VTextReports;


procedure SelectFileInExplorer(const a_Fn: string);
begin
{$IFDEF MSWINDOWS}
  ShellExecute(FmxHandleToHWND(Application.MainForm.Handle), 'open', 'explorer.exe',
  //  PWideChar('/select,"' +ExcludeTrailingPathDelimiter(a_Fn)+'"'), nil,1);  //- select folder from 1 up level opening
  PWideChar('"' +ExcludeTrailingPathDelimiter(a_Fn)+'"'), nil,1);
{$ENDIF}
end;


procedure TVIDirectForm.actAddTaskExecute(Sender: TObject);
begin
 with VD_DM.FDT_Tasks do
   begin
     Append;
     FieldByName('USER_ID').AsInteger:=VD_DM.FDT_Users.FieldByName('ID').AsInteger;
     FieldByName('WORK_ID').AsInteger:=VD_DM.FDT_works.FieldByName('ID').AsInteger;
     FieldByName('B_DATE').AsDateTime:=Now;
     FieldByName('E_DATE').AsDateTime:=IncWeek(Now);

     FieldByName('U_REMARKS').AsWideString:='New Task for '+VD_DM.FDT_Users.FieldByName('NAME').AsWideString+
                                            ' (work DEF)';
     FieldByName('COMMENTARY').AsWideString:='No comment';
     FieldByName('STATE').AsInteger:=0;
     FieldByName('PAID').AsInteger:=0;
     FieldByName('CATALOG').AsWideString:=FDefPath;
     if VD_DM.FDT_works.FieldByName('CATALOG').IsNull=false then
        FieldByName('CATALOG').AsWideString:=VD_DM.FDT_works.FieldByName('CATALOG').AsWideString;
     FieldByName('GROUP_ID').AsInteger:=0;
     FieldByName('SIGN').AsInteger:=0;
     Post;
   end;
end;

procedure TVIDirectForm.actAddUserExecute(Sender: TObject);
begin
  with VD_DM.FDT_Users do
   begin
     Append;
     FieldByName('U_DATE').AsDateTime:=Now;
     FieldByName('NAME').AsString:='New User';
     FieldByName('U_INFO').AsWideString:='no Information';
     FieldByName('GROUP_ID').AsInteger:=0;
     FieldByName('SIGN').AsInteger:=0;
     Post;
   end;
end;

procedure TVIDirectForm.actAddWorkExecute(Sender: TObject);
begin
 with VD_DM.FDT_works do
   begin
     Append;
     FieldByName('USER_ID').AsInteger:=VD_DM.FDT_Users.FieldByName('ID').AsInteger;
     FieldByName('INFO').AsWideString:='New Work for User:  '+VD_DM.FDT_Users.FieldByName('NAME').AsWideString;
     FieldByName('B_DATE').AsDateTime:=Now;
     FieldByName('E_DATE').AsDateTime:=IncMonth(Now);
     FieldByName('COMMENTARY').AsWideString:='No comment';
     FieldByName('STATE').AsInteger:=0;
     FieldByName('CATALOG').AsWideString:=FDefPath;
     FieldByName('PAID').AsInteger:=0;
     FieldByName('SIGN').AsInteger:=0;
     Post;
   end;
end;

procedure TVIDirectForm.actDeleteTaskExecute(Sender: TObject);
begin
 VD_DM.FDT_Tasks.Delete;
end;

procedure TVIDirectForm.actDeleteTaskUpdate(Sender: TObject);
begin
 Taction(Sender).Enabled:=(VD_DM.FDT_Tasks.FieldByName('ID').IsNull=false);
end;

procedure TVIDirectForm.actDeleteUserExecute(Sender: TObject);
begin
  VD_DM.FDT_Users.Delete;
end;

procedure TVIDirectForm.actDeleteUserUpdate(Sender: TObject);
begin
 Taction(Sender).Enabled:=(VD_DM.FDT_Users.FieldByName('ID').IsNull=false);
end;

procedure TVIDirectForm.actDeleteWorkExecute(Sender: TObject);
begin
  VD_DM.FDT_works.Delete;
end;

procedure TVIDirectForm.actDeleteWorkUpdate(Sender: TObject);
begin
 Taction(Sender).Enabled:=(VD_DM.FDT_works.FieldByName('ID').IsNull=false);
end;

procedure TVIDirectForm.actReopenTablesExecute(Sender: TObject);
begin
  VD_DM.conLite.Connected:=false;
  VD_DM.conImages.Connected:=false;
  VD_DM.ConnectTobase;
end;

procedure TVIDirectForm.actTasksReportExecute(Sender: TObject);
var i:Integer;
begin
  if chk_TReport.IsChecked=true then i:=1
  else i:=0;
  if SM_VTextReportsDlg(i,Self) then ;
end;

procedure TVIDirectForm.btn_WSelDirClick(Sender: TObject);
begin
 case TComponent(Sender).Tag of
   0: FillCatalogData(VD_DM.FDT_works,'CATALOG');
   1: FillCatalogData(VD_DM.FDT_Tasks,'CATALOG');
 end;
end;

procedure TVIDirectForm.btn1Click(Sender: TObject);
begin
 // VRep_DM.GenerateTaskList(0);
 SM_ImageDlg(Self,5,0,VD_DM.FDT_Tasks.FieldByName('USER_ID').AsInteger,
                      VD_DM.FDT_Tasks.FieldByName('USER_ID').AsInteger,1);
end;

procedure TVIDirectForm.btnOpenExpClick(Sender: TObject);
begin
  SelectFileInExplorer(VD_DM.FDT_Tasks.FieldByName('CATALOG').AsWideString);
end;

procedure TVIDirectForm.btn_TClearUGraphClick(Sender: TObject);
begin
 case TComponent(Sender).Tag of
    1: ClearBlobData(VD_DM.FDT_Tasks,'U_GRAPH');
    2: ClearBlobData(VD_DM.FDT_Tasks,'GRAPH');
   // 11: ClearBlobData(VD_DM.FDT_Tasks,'GRAPH');
  // 12: ClearBlobData(VD_DM.FDT_Tasks,'GRAPH');
 end;
end;

function TVIDirectForm.ClearBlobData(const ADS: TDataset;
  const aFieldName: string): boolean;
 var LF:TField;
begin
  Result:=false;
  LF:=ADS.FieldByName(aFieldName);
  Assert(Assigned(LF),'DirectForm.ClearBlobData - field not Found!');
  try
    ADS.Edit;
    TBlobField(LF).Clear;
    Result:=true;
  finally
    ADS.Post;
  end;
end;

function TVIDirectForm.FillCatalogData(const ADS: TDataset;
  const aFieldName: string): boolean;
  var LDir:string;
      LF:TField;
begin
 Result:=false;
 LF:=ADS.FieldByName(aFieldName);
 Assert(Assigned(LF),'DirectForm.ClearBlobData - field not Found!');
 ///
 if LF.IsNull=false then
    LDir:=LF.AsWideString
 else LDir:='';
 ///
 if SelectDirectory('Select for '+aFieldName,'',LDir) then
     try
       ADS.Edit;
       LF.AsWideString:=LDir;
       Result:=true;
       finally
      ADS.Post;
     end;
end;

procedure TVIDirectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveToIni;
end;

procedure TVIDirectForm.FormCreate(Sender: TObject);
begin
  actReopenTables.Execute;
  FDefPath:=IncludeTrailingPathDelimiter(GetCurrentDir);
  LocateFromIni(0);
end;

procedure TVIDirectForm.img_GraphLoaded(Sender: TObject;
  const FileName: string);
 var LS,LBS:TStream;
     LFieldName:String;
begin
  case TComponent(Sender).Tag of
   0: LFieldName:='U_GRAPH';
   else
      LFieldName:='GRAPH';
  end;
  ///
  LS:=TFileStream.Create(FileName,fmOpenRead);
  VD_DM.FDT_Tasks.Edit;
  try
   LS.Seek(0,0);
   TBlobField(VD_DM.FDT_Tasks.FieldByName(LFieldName)).LoadFromStream(LS);
  finally
    LS.Free;
    VD_DM.FDT_Tasks.Post;
  end;
end;

function TVIDirectForm.LocateFromIni(aLocRg: integer): Boolean;
var L_UserID,L_WorkID,L_TaskID:integer;
begin
 L_UserID:=appEnv.Ini.ReadInteger('BDATA','USER_ID',0);
 L_WorkID:=appEnv.Ini.ReadInteger('BDATA','WORK_ID',0);
 L_TaskID:=appEnv.Ini.ReadInteger('BDATA','TASK_ID',0);
 Result:=false;
 if L_UserID>0 then
    Result:=VD_DM.FDT_Users.Locate('ID',L_UserID,[]);
 if L_WorkID>0 then
    Result:=(VD_DM.FDT_works.Locate('USER_ID;ID',VarArrayOf([L_UserID,L_WorkID]),[])) and (Result=true);
  if L_TaskID>0 then
    Result:=(VD_DM.FDT_Tasks.Locate('USER_ID;WORK_ID;ID',VarArrayOf([L_UserID,L_WorkID,L_TaskID]),[])) and (Result=true);
end;

function TVIDirectForm.SaveToIni: Boolean;
var L_UserID,L_WorkID,L_TaskID:integer;
begin
 if VD_DM.FDT_Users.FieldByName('ID').IsNull then
    L_UserID:=0
 else L_UserID:=VD_DM.FDT_Users.FieldByName('ID').AsInteger;
 if VD_DM.FDT_works.FieldByName('ID').IsNull then
    L_WorkID:=0
 else L_WorkID:=VD_DM.FDT_works.FieldByName('ID').AsInteger;
 if VD_DM.FDT_Tasks.FieldByName('ID').IsNull then
    L_TaskID:=0
 else L_TaskID:=VD_DM.FDT_Tasks.FieldByName('ID').AsInteger;
 appEnv.Ini.WriteInteger('BDATA','USER_ID',L_UserID);
 appEnv.Ini.WriteInteger('BDATA','WORK_ID',L_WorkID);
 appEnv.Ini.WriteInteger('BDATA','TASK_ID',L_TaskID);
 ///
 Result:=appEnv.Ini.Save;
end;

end.
