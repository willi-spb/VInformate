unit fm_Image;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox, FMX.NumberBox,
  FMX.ScrollBox, FMX.Memo, FMX.DateTimeCtrls;

type
  TImageForm = class(TForm)
    img_TU_Graph: TImageControl;
    mmo_IDESC: TMemo;
    nmbrbx_ImgGroup: TNumberBox;
    lbl_ImgGroup: TLabel;
    dt_ImageAdd: TDateEdit;
    pnl_IMGBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure img_TU_GraphLoaded(Sender: TObject; const FileName: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    FID,FImgType,FtaskId,FUserID,FSign:integer;
    FMStr:TMemoryStream;
  public
    { Public declarations }
    function LoadFromID(aID:integer):boolean;
  end;

var
  ImageForm: TImageForm;

function SM_ImageDlg(AOwner:TComponent; aID,aImgType,AUserId,ATaskID:integer; AGroup:integer=0):boolean;


implementation

uses dm_VIDir, Data.DB;

{$R *.fmx}

function SM_ImageDlg(AOwner:TComponent; aID,aImgType,AUserId,ATaskID:integer; AGroup:integer=0):boolean;
 begin
   Result:=false;
   with TImageForm.Create(AOwner) do
    try
      FSign:=0;
      FID:=0;
      FImgType:=aImgType;
      FtaskId:=ATaskID;
      AUserId:=FUserID;
      dt_ImageAdd.DateTime:=Now;
      nmbrbx_ImgGroup.Value:=AGroup;
      ///
      LoadFromID(aID);
      FID:=aID;
      ///
      Result:=ShowModal=mrOk;
    finally
      Free;
    end;
 end;

procedure TImageForm.btnOkClick(Sender: TObject);
begin
  ///
  FMStr.Seek(0,0);
  if FID>0 then
    VD_DM.FDQ_Images.SQL.Text:='UPDATE IMAGES_T SET ITYPE=:ITYPE, GROUP_ID=:GROUP_ID, TASK_ID=:TASK_ID,'+
    'USER_ID=:USER_ID, IMG=:IMG,IDESC=:IDESC,CDATE=:CDATE,SIGN=:SIGN WHERE (ID=:ID);'
  else
    VD_DM.FDQ_Images.SQL.Text:='INSERT INTO IMAGES_T (ITYPE,GROUP_ID,TASK_ID,USER_ID,IMG,IDESC,CDATE,SIGN) '+
     'VALUES (:ITYPE,:GROUP_ID,:TASK_ID,:USER_ID,:IMG,:IDESC,:CDATE,:SIGN);';
  ///
     with VD_DM.FDQ_Images do
      begin
        if FID>0 then
            ParamByName('ID').AsInteger:=FID;
        ParamByName('ITYPE').AsInteger:=FImgType;
        ParamByName('GROUP_ID').AsInteger:=Trunc(nmbrbx_ImgGroup.Value);
        ParamByName('TASK_ID').AsInteger:=FtaskId;
        ParamByName('USER_ID').AsInteger:=FUserID;
        ParamByName('IMG').LoadFromStream(FMStr,ftBlob);
        ParamByName('IDESC').AsWideString:=mmo_IDESC.Text;
        ParamByName('CDATE').AsDateTime:=dt_ImageAdd.DateTime;
        ParamByName('SIGN').AsInteger:=FSign;
        VD_DM.FDQ_Images.ExecSQL;
        if FID=0 then
          begin
           SQL.Text:='select last_insert_rowid();';
           VD_DM.FDQ_Images.Open;
           FID:=Fields[0].AsInteger;
           VD_DM.FDQ_Images.Close;
          end;
      end;
  ///
  ModalResult:=mrOk;
end;

procedure TImageForm.FormCreate(Sender: TObject);
begin
 FMStr:=TMemoryStream.Create;
end;

procedure TImageForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FMStr);
end;

procedure TImageForm.img_TU_GraphLoaded(Sender: TObject; const FileName: string);
begin
  ///
  FMStr.LoadFromFile(FileName);
end;

function TImageForm.LoadFromID(aID:integer): boolean;
begin
  Result:=false;
  if aID=0 then exit;
  VD_DM.FDQ_Images.SQL.Text:='SELECT * FROM IMAGES_T WHERE (ID='+IntToStr(aID)+');';
  try
  VD_DM.FDQ_Images.Open;
  with VD_DM.FDQ_Images do
    if (FieldByName('ID').IsNull=false) and (FieldByName('ID').Asinteger<>0) then
      begin
        FImgType:=FieldByName('ITYPE').AsInteger;
        nmbrbx_ImgGroup.Value:=FieldByName('GROUP_ID').AsInteger;
        FUserID:=FieldByName('USER_ID').AsInteger;
        FtaskId:=FieldByName('TASK_ID').AsInteger;
        mmo_IDESC.Text:=FieldByName('IDESC').AsWideString;
        FSign:=FieldByName('SIGN').AsInteger;
        ///
        FMStr.Clear;
        FMStr.Seek(0,0);
        TBlobField(FieldByName('IMG')).SaveToStream(FMStr);
        img_TU_Graph.Bitmap.LoadFromStream(FMStr);
        FMStr.Seek(0,0);
        Result:=true;
        ///
      end;
  finally
   VD_DM.FDQ_Images.Close;
  end;
end;

end.
