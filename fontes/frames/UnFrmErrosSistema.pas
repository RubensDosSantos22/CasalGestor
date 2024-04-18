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
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
        TShiftState);
    procedure SpBtAcao1Click(Sender: TObject);
    procedure SpBtFecharErroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmErroSistema: TFrmErroSistema;

implementation

{$R *.fmx}

procedure TFrmErroSistema.FormKeyUp(Sender: TObject; var Key: Word; var
    KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
    begin
      FrmErroSistema.Close;
    end;
end;

procedure TFrmErroSistema.SpBtAcao1Click(Sender: TObject);
begin
  FrmErroSistema.Close;
end;

procedure TFrmErroSistema.SpBtFecharErroClick(Sender: TObject);
begin
  FrmErroSistema.Close;
end;

end.