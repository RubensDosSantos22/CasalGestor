unit UnFrmErrosSistema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrmErroSistema = class(TForm)
    Rct1: TRectangle;
    Lyt1: TLayout;
    LblDescricaoErro: TLabel;
    ImgErro: TImage;
    Rct2: TRectangle;
    Lyt3: TLayout;
    SpBtAcao1: TSpeedButton;
    Lbl1: TLabel;
    SpBtAcao2: TSpeedButton;
    Lbl2: TLabel;
    RctTituloErro: TRectangle;
    SpBtFecharErro: TSpeedButton;
    LblBtParcelas: TLabel;
    LblTituloErro: TLabel;
    ImgAviso: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
        TShiftState);
    procedure SpBtAcao1Click(Sender: TObject);
    procedure SpBtAcao2Click(Sender: TObject);
    procedure SpBtFecharErroClick(Sender: TObject);
  private
    { Private declarations }
  public
    OpcaoSelecionada: Boolean;
  end;

var
  FrmErroSistema: TFrmErroSistema;

implementation

{$R *.fmx}

procedure TFrmErroSistema.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //FreeAndNil(FrmErroSistema);
end;

procedure TFrmErroSistema.FormKeyUp(Sender: TObject; var Key: Word; var
    KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
    begin
      SpBtAcao1.OnClick(Sender);
    end;
end;

procedure TFrmErroSistema.SpBtAcao1Click(Sender: TObject);
begin
  OpcaoSelecionada:= True;
  FrmErroSistema.Close;
end;

procedure TFrmErroSistema.SpBtAcao2Click(Sender: TObject);
begin
  OpcaoSelecionada:= False;
  FrmErroSistema.Close;
end;

procedure TFrmErroSistema.SpBtFecharErroClick(Sender: TObject);
begin
  OpcaoSelecionada:= False;
  FrmErroSistema.Close;
end;

end.
