program PhoneAgend3;

uses
  System.StartUpCopy,
  FMX.Forms,
  Index in 'Index.pas' {FrIndex},
  LibDesign in 'lib\project\LibDesign.pas',
  UnContasAReceber in 'UnContasAReceber.pas' {FrContasAReceber},
  UnContasAPagar in 'UnContasAPagar.pas' {FrContasAPagar},
  LibAcoes in 'lib\project\LibAcoes.pas',
  LibDatabase in 'lib\project\LibDatabase.pas',
  DmMaster in 'database\DmMaster.pas' {Dm: TDataModule},
  UnFrmErrosSistema in 'Frames\UnFrmErrosSistema.pas' {FrmErroSistema},
  UnFrmItensContas in 'Frames\UnFrmItensContas.pas' {FrmItensContas: TFrame},
  UnControleErros in 'Controles\UnControleErros.pas',
  UnDBcontasAReceber in 'Controles\database\UnDBcontasAReceber.pas',
  UnDBcontasAPagar in 'Controles\database\UnDBcontasAPagar.pas';

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
