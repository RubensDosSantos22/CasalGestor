unit Index;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.TabControl,

  LibControlGrids,
  LibTools,
  UnContasAPagar,
  UnContasAReceber, FMX.Layouts;

type
  TFrIndex = class(TForm)
    ImgBackground: TImage;
    RctPnlWorkShp: TRectangle;
    Lyt1: TLayout;
    RctPnlLogo: TRectangle;
    ImgLogo: TImage;
    LblNomeLogo: TLabel;
    anInvisibleLblNomeLogo: TFloatAnimation;
    anVisibleLblNomeLogo: TFloatAnimation;
    anSizeHPnlLogo: TFloatAnimation;
    anSizeHPnlLogo1: TFloatAnimation;
    GdLytBotoesAcesso: TGridLayout;
    RctBtContasAReceber: TRectangle;
    ImgBtConversoes: TImage;
    LblBtConversoes: TLabel;
    anHoverBtContasAReceber: TFloatAnimation;
    anUnhoverBtContasAReceber: TFloatAnimation;
    RctBtContasAPagar: TRectangle;
    ImgBtCadastros: TImage;
    LblBtcadastros: TLabel;
    anHoverBtContasAPagar: TFloatAnimation;
    anUnhoverBtContasAPagar: TFloatAnimation;
    RctBtCadastroDeBancos: TRectangle;
    ImgBtCadastroDeBancos: TImage;
    LblBtCadastroDeBancos: TLabel;
    anHoverBtCadastroDeBancos: TFloatAnimation;
    anUnhoverBtCadastroDeBancos: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
        TShiftState);
    procedure RctBtContasAPagarMouseEnter(Sender: TObject);
    procedure RctBtContasAPagarMouseLeave(Sender: TObject);
    procedure RctBtContasAReceberMouseEnter(Sender: TObject);
    procedure RctBtContasAReceberMouseLeave(Sender: TObject);
    procedure RctBtContasAPagarClick(Sender: TObject);
    procedure RctBtContasAReceberClick(Sender: TObject);
    procedure ImgBtCloseApplicationClick(Sender: TObject);
    procedure RctPnlFormClick(Sender: TObject);
    procedure RctBtCadastroDeBancosClick(Sender: TObject);
    procedure RctBtCadastroDeBancosMouseEnter(Sender: TObject);
    procedure RctBtCadastroDeBancosMouseLeave(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  FrIndex: TFrIndex;

implementation

{$R *.fmx}


//---[BT] - (CADASTROS) ----------------------------------

procedure TFrIndex.RctBtCadastroDeBancosClick(Sender: TObject);
begin
  //pass
end;

procedure TFrIndex.RctBtCadastroDeBancosMouseEnter(Sender: TObject);
begin
  anHoverBtCadastroDeBancos.Start;
end;

procedure TFrIndex.RctBtCadastroDeBancosMouseLeave(Sender: TObject);
begin
  anUnhoverBtCadastroDeBancos.Start;
end;

procedure TFrIndex.RctBtContasAPagarClick(Sender: TObject);
begin
  FrContasAPagar:= TFrContasAPagar.Create(Application);
  //ActualScreen:= FrContasAPagar;
  FrContasAPagar.Show;
end;

procedure TFrIndex.RctBtContasAPagarMouseEnter(Sender: TObject);
begin
  anHoverBtContasAPagar.Start;
end;

procedure TFrIndex.RctBtContasAPagarMouseLeave(Sender: TObject);
begin
  anUnHoverBtContasAPagar.Start;
end;

//--------------------------------------------------------

//---[BT] - (CONVERSÕES) ---------------------------------

procedure TFrIndex.RctBtContasAReceberClick(Sender: TObject);
begin
  FrContasAReceber:= TFrContasAReceber.Create(Application);
//  ActualScreen:= FrContasAReceber;
  FrContasAReceber.Show;
end;

procedure TFrIndex.RctBtContasAReceberMouseEnter(Sender: TObject);
begin
  anHoverBtContasAReceber.Start;
end;

procedure TFrIndex.RctBtContasAReceberMouseLeave(Sender: TObject);
begin
  anUnhoverBtContasAReceber.Start;
end;

//--------------------------------------------------------

//---[BT] - (FECHAR APLICAÇÃO) ---------------------------

procedure TFrIndex.ImgBtCloseApplicationClick(Sender: TObject);
begin
  Application.Terminate;
end;

//--------------------------------------------------------

//---[FR] - (INDEX) --------------------------------------

procedure TFrIndex.FormCreate(Sender: TObject);
begin
//  ActualScreen:= FrIndex;
end;

procedure TFrIndex.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar:
    Char; Shift: TShiftState);
begin
  if Key = 35 then //End - Encerrar Aplicação
    begin
      Application.Terminate;
    end;
end;

procedure TFrIndex.RctPnlFormClick(Sender: TObject);
begin

end;

//--------------------------------------------------------
end.
