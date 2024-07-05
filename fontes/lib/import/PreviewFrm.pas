unit PreviewFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, fmxRVScroll, fmxCRVPP, fmxRVPP,
  FMX.ComboEdit, FMX.Edit, FMX.EditBox, FMX.SpinBox, fmxPtblRV;

type
  TfrmPreview = class(TForm)
    ToolBar1: TToolBar;
    RVPrintPreview1: TRVPrintPreview;
    spbPages: TSpinBox;
    cmbZoom: TComboEdit;
    Label1: TLabel;
    Label2: TLabel;
    lblPageCount: TLabel;
    procedure spbPagesChange(Sender: TObject);
    procedure cmbZoomChange(Sender: TObject);
    procedure RVPrintPreview1ZoomChanged(Sender: TObject);
  private
    { Private declarations }
    FUpdatingZoomComboBox: Boolean;
    procedure UpdateZoomComboBox;
  public
    { Public declarations }
    procedure Init(ARVPrint: TRVPrint);
  end;

var
  frmPreview: TfrmPreview;

implementation

{$R *.fmx}

{================================ TfrmPreview =================================}
procedure TfrmPreview.Init(ARVPrint: TRVPrint);
begin
  RVPrintPreview1.RVPrint := ARVPrint;
  RVPrintPreview1.PageNo := 1;
  spbPages.Value := 1;
  lblPageCount.Text := 'of ' + IntToStr(ARVPrint.PagesCount);
  spbPages.Max := ARVPrint.PagesCount;
  UpdateZoomComboBox;
end;
{------------------------------------------------------------------------------}
procedure TfrmPreview.spbPagesChange(Sender: TObject);
begin
  RVPrintPreview1.PageNo := Round(spbPages.Value);
end;
{------------------------------------------------------------------------------}
const
  FullPageStr  = 'Full page';
  PageWidthStr = 'Page width';
procedure TfrmPreview.UpdateZoomComboBox;
begin
  if FUpdatingZoomComboBox then
    exit;
  FUpdatingZoomComboBox := True;
  case RVPrintPreview1.ZoomMode of
    rvzmFullPage:
      cmbZoom.Text := FullPageStr;
    rvzmPageWidth:
      cmbZoom.Text := PageWidthStr;
    else
      cmbZoom.Text := IntToStr(Round(RVPrintPreview1.ZoomPercent)) + '%';
  end;
  FUpdatingZoomComboBox := False;
end;
{------------------------------------------------------------------------------}
procedure TfrmPreview.cmbZoomChange(Sender: TObject);
var
  S: String;
begin
  FUpdatingZoomComboBox := True;
  try
    S := cmbZoom.Text;
    if S = FullPageStr then
      RVPrintPreview1.ZoomMode := rvzmFullPage
    else if S = PageWidthStr then
      RVPrintPreview1.ZoomMode := rvzmPageWidth
    else if S <> '' then
    begin
      if S[High(S)] = '%' then
        Delete(S, Length(S), 1);
      RVPrintPreview1.ZoomMode := rvzmCustom;
      RVPrintPreview1.ZoomPercent := StrToFloatDef(S, 100);
    end;
  finally
    FUpdatingZoomComboBox := False;
  end;
  UpdateZoomComboBox;
end;
{------------------------------------------------------------------------------}
procedure TfrmPreview.RVPrintPreview1ZoomChanged(Sender: TObject);
begin
  UpdateZoomComboBox;
end;

end.
