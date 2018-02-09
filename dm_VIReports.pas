unit dm_VIReports;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPProd, Web.DBWeb, Web.HTTPApp,
  Web.DSProd,
  dm_VIDir;

type
  TVRep_DM = class(TDataModule)
    DataSetTableProducer1: TDataSetTableProducer;
    PageProducer1: TPageProducer;
    DataSetPageProducer1: TDataSetPageProducer;
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    function GenerateTaskList(rg:integer):integer;
  end;

var
  VRep_DM: TVRep_DM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TVRep_DM }

function TVRep_DM.GenerateTaskList(rg: integer): integer;
var LStr:TStringStream;
begin
  LStr:=TStringStream.Create(PageProducer1.Content,TEncoding.UTF8);
  try
    LStr.SaveToFile('ttt.html');
  finally
   FreeAndNil(LStr);
  end;
end;

procedure TVRep_DM.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
 if TagString='UserName' then
    ReplaceText:=DataSetTableProducer1.Content;
end;

end.
