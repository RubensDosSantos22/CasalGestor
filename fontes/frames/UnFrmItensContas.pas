unit UnFrmItensContas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrmItensContas = class(TFrame)
    LblConta: TLabel;
    LblPagamento: TLabel;
    LblVencimento: TLabel;
    LblValor: TLabel;
    SpBtDeleteItem: TSpeedButton;
    Img1: TImage;
    procedure FrameMouseEnter(Sender: TObject);
    procedure FrameMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
   ItemSelecionado: array of string;

implementation

{$R *.fmx}

procedure TFrmItensContas.FrameMouseEnter(Sender: TObject);
begin
  LblConta.Opacity:= 0.5;
end;

procedure TFrmItensContas.FrameMouseLeave(Sender: TObject);
begin
  LblConta.Opacity:= 1;
end;

end.
