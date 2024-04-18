unit Index;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, LibDesign, FMX.TabControl, UnContasAPagar,
  UnContasAReceber;

type
  TFrIndex = class(TForm)
    ImgBackground: TImage;
    RctPnlMenu: TRectangle;
    anSizeWPnlMenu: TFloatAnimation;
    anSizeWPnlMenu1: TFloatAnimation;
    RctPnlLogo: TRectangle;
    ImgLogo: TImage;
    LblNomeLogo: TLabel;
    anInvisibleLblNomeLogo: TFloatAnimation;
    anVisibleLblNomeLogo: TFloatAnimation;
    anSizeHPnlLogo: TFloatAnimation;
    anSizeHPnlLogo1: TFloatAnimation;
    RctBtCadastros: TRectangle;
    ImgBtCadastros: TImage;
    LblBtcadastros: TLabel;
    anVisibleLblBtCadastros: TFloatAnimation;
    anInvisibleLblBtCadastros: TFloatAnimation;
    anHoverBtCadastros: TFloatAnimation;
    anUnhoverBtCadastros: TFloatAnimation;
    RctPnlNav: TRectangle;
    ImgBtCloseApplication: TImage;
    anHoverBtClose: TFloatAnimation;
    anUnhoverBtClose: TFloatAnimation;
    RctPnlWorkShp: TRectangle;
    RctBtConversoes: TRectangle;
    ImgBtConversoes: TImage;
    LblBtConversoes: TLabel;
    anVisibleLblBtConversoes: TFloatAnimation;
    anInvisibleLblBtConversoes: TFloatAnimation;
    anHoverBtConversoes: TFloatAnimation;
    anUnhoverBtConversoes: TFloatAnimation;

  {$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure ImgBtCloseApplicationMouseLeave(Sender: TObject);
    procedure ImgBtCloseApplicationMouseEnter(Sender: TObject);
    procedure RctBtCadastrosMouseEnter(Sender: TObject);
    procedure RctBtCadastrosMouseLeave(Sender: TObject);
    procedure RctBtConversoesMouseEnter(Sender: TObject);
    procedure RctBtConversoesMouseLeave(Sender: TObject);
    procedure RctBtCadastrosClick(Sender: TObject);
    procedure RctBtConversoesClick(Sender: TObject);
    procedure ImgBtCloseApplicationClick(Sender: TObject);
    procedure RctPnlFormClick(Sender: TObject);
  private
    Anim1: animNoTime;
  public
    { Public declarations }
  end;

var
  FrIndex: TFrIndex;

implementation

{$R *.fmx}


//---[BT] - (CADASTROS) ----------------------------------

procedure TFrIndex.RctBtCadastrosClick(Sender: TObject);
begin
  FrContasAPagar:= TFrContasAPagar.Create(Application);
  ActualScreen:= FrContasAPagar;
  FrContasAPagar.Show;
end;

procedure TFrIndex.RctBtCadastrosMouseEnter(Sender: TObject);
begin
  anHoverBtCadastros.Start;
end;

procedure TFrIndex.RctBtCadastrosMouseLeave(Sender: TObject);
begin
  anUnHoverBtCadastros.Start;
end;

//--------------------------------------------------------

//---[BT] - (CONVERSÕES) ---------------------------------

procedure TFrIndex.RctBtConversoesClick(Sender: TObject);
begin
  FrContasAReceber:= TFrContasAReceber.Create(Application);
  ActualScreen:= FrContasAReceber;
  FrContasAReceber.Show;
end;

procedure TFrIndex.RctBtConversoesMouseEnter(Sender: TObject);
begin
  anHoverBtConversoes.Start;
end;

procedure TFrIndex.RctBtConversoesMouseLeave(Sender: TObject);
begin
  anUnhoverBtConversoes.Start;
end;

//--------------------------------------------------------

//---[BT] - (FECHAR APLICAÇÃO) ---------------------------

procedure TFrIndex.ImgBtCloseApplicationMouseLeave(Sender: TObject);
begin
  anUnhoverBtClose.Start;
end;

procedure TFrIndex.ImgBtCloseApplicationMouseEnter(Sender: TObject);
begin
  anHoverBtClose.Start;
end;

procedure TFrIndex.ImgBtCloseApplicationClick(Sender: TObject);
begin
  Application.Terminate;
end;

//--------------------------------------------------------

//---[FR] - (INDEX) --------------------------------------

procedure TFrIndex.FormCreate(Sender: TObject);
begin
  ActualScreen:= FrIndex;
  Anim1.abreMenu;
end;

procedure TFrIndex.RctPnlFormClick(Sender: TObject);
begin

end;

//--------------------------------------------------------
end.
