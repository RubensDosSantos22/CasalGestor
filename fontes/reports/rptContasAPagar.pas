unit rptContasAPagar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, ppBands,
  ppCache, ppClass, ppDesignLayer, ppParameter, ppComm, ppRelatv, ppProd,
  ppReport, ppDB, ppDBPipe, ppEndUsr, Data.DB, ppDBBDE;

type
  TForm2 = class(TForm)
    RptResumoDasDespesas: TppReport;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    BdePpl1: TppBDEPipeline;
    Ds1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
    DmMaster;

{$R *.fmx}

end.
