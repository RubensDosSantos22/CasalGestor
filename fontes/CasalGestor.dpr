program CasalGestor;

uses
  System.StartUpCopy,
  FMX.Forms,
  Index in 'Index.pas' {FrIndex},
  LibDesign in 'lib\project\LibDesign.pas',
  UnContasAReceber in 'UnContasAReceber.pas' {FrContasAReceber},
  UnContasAPagar in 'UnContasAPagar.pas' {FrContasAPagar},
  LibAcoes in 'lib\project\LibAcoes.pas',
  DmMaster in 'database\DmMaster.pas' {Dm: TDataModule},
  UnFrmErrosSistema in 'Frames\UnFrmErrosSistema.pas' {FrmErroSistema},
  UnFrmItensContas in 'Frames\UnFrmItensContas.pas' {FrmItensContas: TFrame},
  UnDBcontasAPagar in 'controllers\UnDBcontasAPagar.pas',
  UnDBcontasAReceber in 'controllers\UnDBcontasAReceber.pas',
  UnControleErros in 'frames\controllers\UnControleErros.pas',
  LibDatabase in 'lib\project\LibDatabase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrIndex, FrIndex);
  Application.CreateForm(TFrContasAPagar, FrContasAPagar);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmErroSistema, FrmErroSistema);
  //Application.CreateForm(TFrCadastros, FrCadastros);
  Application.Run;
end.
