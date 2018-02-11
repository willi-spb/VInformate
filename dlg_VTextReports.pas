unit dlg_VTextReports;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TVTextReportsForm = class(TForm)
    mmoRT: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VTextReportsForm: TVTextReportsForm;

  function SM_VTextReportsDlg(rg:Integer; AOwner:TComponent):Boolean;


implementation

{$R *.fmx}

uses dm_VIDir, dm_ViReports;

function SM_VTextReportsDlg(rg:Integer; AOwner:TComponent):Boolean;
 begin
   Result:=False;
   with TVTextReportsForm.Create(Aowner) do
   try
     mmoRT.Lines.Clear;
     VD_DM.PrepareTasksReport(0,mmoRT.Lines);
     Result:=ShowModal=mrOk;
   finally
     Free;
   end;
 end;


end.
