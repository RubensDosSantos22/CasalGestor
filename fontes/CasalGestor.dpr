program CasalGestor;

uses
  System.StartUpCopy,
  FMX.Forms,
  Index in 'Index.pas' {FrIndex},
  LibControlGrids in 'lib\project\LibControlGrids.pas',
  UnContasAReceber in 'UnContasAReceber.pas' {FrContasAReceber},
  UnContasAPagar in 'UnContasAPagar.pas' {FrContasAPagar},
  LibTools in 'lib\project\LibTools.pas',
  DmMaster in 'database\DmMaster.pas' {Dm: TDataModule},
  UnFrmErrosSistema in 'Frames\UnFrmErrosSistema.pas' {FrmErroSistema},
  UnFrmItensContas in 'Frames\UnFrmItensContas.pas' {FrmItensContas: TFrame},
  UnDBcontasAPagar in 'controllers\UnDBcontasAPagar.pas',
  UnDBcontasAReceber in 'controllers\UnDBcontasAReceber.pas',
  UnControleErros in 'frames\controllers\UnControleErros.pas',
  UnDBcadastros in 'controllers\UnDBcadastros.pas',
  UnDBlancamentos in 'controllers\UnDBlancamentos.pas',
  UnLoading in 'UnLoading.pas' {FrLoading},
  UnInstalacao in 'UnInstalacao.pas' {Form1},
  LibSetup in 'lib\LibSetup.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrIndex, FrIndex);
  Application.CreateForm(TFrContasAPagar, FrContasAPagar);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmErroSistema, FrmErroSistema);
  Application.CreateForm(TFrLoading, FrLoading);
  Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TFrCadastros, FrCadastros);
  Application.Run;
end.
