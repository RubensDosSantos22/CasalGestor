program CasalGestor;

{$R *.dres}

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
  rptContasAPagar in 'reports\rptContasAPagar.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrIndex, FrIndex);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TForm2, Form2);
  //Application.CreateForm(TFrCadastros, FrCadastros);
  Application.Run;
end.
