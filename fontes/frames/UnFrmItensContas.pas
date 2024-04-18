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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
