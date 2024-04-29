unit UnLoading;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Ani;

type
  TFrLoading = class(TForm)
    ImgBackground: TImage;
    RctPnlWorkShp: TRectangle;
    pb1: TProgressBar;
    LblNomeLogo: TLabel;
    anInvisibleLblNomeLogo: TFloatAnimation;
    anVisibleLblNomeLogo: TFloatAnimation;
    RctPnlLogo: TRectangle;
    ImgLogo: TImage;
    anSizeHPnlLogo: TFloatAnimation;
    anSizeHPnlLogo1: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrLoading: TFrLoading;

implementation

uses
    DmMaster;

{$R *.fmx}

procedure TFrLoading.FormCreate(Sender: TObject);
begin

  ConnectFBase;

  //pass
end;

end.
