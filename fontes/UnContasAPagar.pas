unit UnContasAPagar;

interface

{$REGION 'Declarações'}

uses
    {$REGION 'Bibliotecas da tela'}

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Ani,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListBox,
  FMX.DateTimeCtrls,
  FMX.Edit,
  FMX.ListView,
  FMX.TabControl,
  FMX.Layouts,
  FMX.Dialogs.Win,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,

  vcl.Dialogs,

  LibControlGrids,
  UnDBcontasAPagar,
  UnFrmItensContas,
  UnControleErros,
  UnDBcadastros,
  LibTools;

    {$ENDREGION}

type

    {$REGION 'função do cabeçalho de botões'}

  navBar = class
     procedure Editar;
     procedure Excluir;
     procedure Adicionar;
     procedure Pesquisar;
     procedure Cancelar;
     procedure Salvar(tp: string);
  end;

  {$ENDREGION}

  TFrContasAPagar = class(TForm)

    {$REGION 'Declaração dos compoenntes da tela'}

    ImgBackground: TImage;
    RctPnlWorkShp: TRectangle;
    TbWork: TTabControl;
    TbItLancamento: TTabItem;
    RctLancarConta: TRectangle;
    RctDadosConta: TRectangle;
    TbItConsulta: TTabItem;
    RctConsulta: TRectangle;
    RctFiltrosConsulta: TRectangle;
    LblTotalContas: TLabel;
    GpPeriodoConsulta: TGroupBox;
    DeInicioConsulta: TDateEdit;
    LblPeriodoPesquisaDe: TLabel;
    LblPeriodoPesquisaAte: TLabel;
    DeFimConsulta: TDateEdit;
    RbTipoPagamento: TRadioButton;
    RbTipoVencimento: TRadioButton;
    LstBxConsulta: TListBox;
    LytNomeConta: TLayout;
    LblNomeConta: TLabel;
    EdtCodigoConta: TEdit;
    EdtNomeConta: TEdit;
    LytDatas: TLayout;
    LblDataPagamento: TLabel;
    DePagamento: TDateEdit;
    LblDataVencimento: TLabel;
    DeVencimento: TDateEdit;
    TbItParcelas: TTabItem;
    RctLancarParcela: TRectangle;
    RctDadosDaParcela: TRectangle;
    LytLancarUmaParcela: TLayout;
    LblPagamentoParcela: TLabel;
    DePagamentoParcela: TDateEdit;
    DeVencimentoParcela: TDateEdit;
    LblVencimentoParcela: TLabel;
    LytLancarVariasParcelas: TLayout;
    RctPnlTituloTela: TRectangle;
    LytTituloTela: TLayout;
    LblTituloTela: TLabel;
    GdLytNavBotoesTela: TGridLayout;
    ImgIconeTela: TImage;
    RctBtNovo: TRectangle;
    SpBtNovo: TSpeedButton;
    ImgBtNovo: TImage;
    LblBtNovo: TLabel;
    RctBtCancelar: TRectangle;
    SpBtCancelar: TSpeedButton;
    ImgBtCancelar: TImage;
    LblBtCancelar: TLabel;
    RctBtSalvar: TRectangle;
    SpBtSalvarRegistro: TSpeedButton;
    ImgBtSalvar: TImage;
    LblBtSalvar: TLabel;
    RctBtEditar: TRectangle;
    SpBtEditar: TSpeedButton;
    LblBtEditar: TLabel;
    ImgBtEditar: TImage;
    RctBtDeletar: TRectangle;
    SpBtDeletar: TSpeedButton;
    LblBtDeletar: TLabel;
    ImgBtDeletar: TImage;
    SpBtAjuda: TSpeedButton;
    ImgBtAjuda: TImage;
    LytInformacoesPrincipais: TLayout;
    LblTipoConta: TLabel;
    CbTiposDeContas: TComboBox;
    EdtValorDaConta: TEdit;
    LblValorConta: TLabel;
    LytLancamento: TLayout;
    LblLancamento: TLabel;
    ImgLancamento: TImage;
    LytParcelas: TLayout;
    LblParcelas: TLabel;
    ImgParcelas: TImage;
    LytConsultar: TLayout;
    LblConsultar: TLabel;
    ImgIconeConsultar: TImage;
    RctBtConsultar_0: TRectangle;
    SpBtConsultar_0: TSpeedButton;
    ImgBtConsultar_0L: TImage;
    LblConsultar_0: TLabel;
    ImgBtConsultar_0R: TImage;
    RctBtConsultar: TRectangle;
    SpBtConsultar_2: TSpeedButton;
    ImgBtConsultar_2: TImage;
    LblBtConsultar_2: TLabel;
    RctBtConsultar_1: TRectangle;
    SpBtConsultar_1: TSpeedButton;
    ImgBtConsultar_1L: TImage;
    LblBtConsultar_1: TLabel;
    ImgBtConsultar_1R: TImage;
    LytVisualizaParcelas: TLayout;
    LstBxParcelasAPagar: TListBox;
    LblParcelasAPagar: TLabel;
    LblParcelasPagas: TLabel;
    LytDadosParcelas: TLayout;
    LblVariasParcelas: TLabel;
    RctBarraDivisora1: TRectangle;
    LytGeracao: TLayout;
    EdtQtdParcelas: TEdit;
    LblQtdParcelas: TLabel;
    SpBtGerarParcelas: TSpeedButton;
    ImgSpBtGerarParcelas: TImage;
    EdtValorParcela: TEdit;
    LblValorParcela: TLabel;
    LytVencimentoEmDiasCorridos: TLayout;
    CbVencimentoEmDias: TCheckBox;
    EdtVencimentoEmDiasParcelas: TEdit;
    LblVencimentoEmDias: TLabel;
    LytParcelamentoPorDiaFIxo: TLayout;
    CbVencimentoDiaFixo: TCheckBox;
    DeVencimentoDiaFixoParcela: TDateEdit;
    LblVencimentoDiaFixo: TLabel;
    EdtVencimentoDiaFixoMes: TEdit;
    DeVencimentoEmDias: TDateEdit;
    RctBtAdicionarParcela: TRectangle;
    SpBtAdicionarParcela: TSpeedButton;
    ImgBtParcelas: TImage;
    LblBtParcelas: TLabel;
    LytRodapeParcela: TLayout;
    RctBtAbaDadosDaConta: TRectangle;
    SpBtAbaDadosDaConta: TSpeedButton;
    ImgBtAbaDadosDaContaL: TImage;
    LblBtAbaDadosDaConta: TLabel;
    ImgBtAbaDadosDaContaR: TImage;
    LytRodapeLancamento: TLayout;
    RctBtAbaParcelas: TRectangle;
    SpBtAbaParcelas: TSpeedButton;
    ImgBtAbaParcelasL: TImage;
    LblBtAbaParcelas: TLabel;
    ImgBtAbaParcelasR: TImage;

    {$ENDREGION}

    {$REGION 'Declaração das procedures e variáveis da tela'}

    procedure CbVencimentoDiaFixoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CbTiposDeContasExit(Sender: TObject);
    procedure CbVencimentoEmDiasChange(Sender: TObject);
    procedure DeFimConsultaExit(Sender: TObject);
    procedure DeInicioConsultaExit(Sender: TObject);
    procedure EdtValorDaContaExit(Sender: TObject);
    procedure EdtValorDaContaKeyDown(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure EdtValorDaContaKeyUp(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure EdtValorParcelaEnter(Sender: TObject);
    procedure EdtValorParcelaExit(Sender: TObject);
    procedure EdtValorParcelaKeyDown(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure EdtValorParcelaKeyUp(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImgBtCloseApplicationClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
        TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RbTipoPagamentoChange(Sender: TObject);
    procedure RbTipoVencimentoChange(Sender: TObject);
    procedure SpBtAbaDadosDaContaClick(Sender: TObject);
    procedure SpBtConsultar_2Click(Sender: TObject);
    procedure SpBtConsultar_1Click(Sender: TObject);
    procedure SpBtConsultar_0Click(Sender: TObject);
    procedure SpBtSalvarRegistroClick(Sender: TObject);
    procedure SpBtAdicionarParcelaClick(Sender: TObject);
    procedure SpBtCancelarClick(Sender: TObject);
    procedure SpBtDeletarClick(Sender: TObject);
    procedure SpBtEditarClick(Sender: TObject);
    procedure SpBtNovoClick(Sender: TObject);
    procedure SpBtAbaParcelasClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure FormActivate(Sender: TObject);
    procedure LstBxConsultaGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure LstBxConsultaMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure LstBxConsultaMouseEnter(Sender: TObject);
    procedure LstBxConsultaMouseLeave(Sender: TObject);
    procedure LstBxConsultaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure LstBxParcelasAPagarGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure LstBxParcelasAPagarMouseEnter(Sender: TObject);
    procedure LstBxParcelasAPagarMouseLeave(Sender: TObject);
    procedure LstBxParcelasAPagarMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure LstBxParcelasAPagarMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; var Handled: Boolean);
    procedure EdtValorDaContaEnter(Sender: TObject);
    procedure CbTiposDeContasKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtNomeContaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure SpBtGerarParcelasClick(Sender: TObject);

  private
    ItemGrids : TItemGrids;
    Acoes     : TAcoes;

    Botoes: Navbar;
    TipodatConsulta, chaveRegistroEdicao: Integer;
  public
    Lanca_Parcela, Permite_Alteracao: Boolean;
    Valor: string;
    NovoOuEdita: string;

    {$ENDREGION}

  end;

var
   Base: DBPagar;
   E: Erro;
   A: Aviso;
   LancarParcela: Boolean;
   formatoValor: string = '###,###,##0.00';

var
  FrContasAPagar: TFrContasAPagar;

{$ENDREGION}

implementation

uses
    UnFrmErrosSistema;

{$REGION 'Ações extras do Formulário'}

procedure Limparcampos;
begin

  with FrContasAPagar do
    begin
      CbTiposDeContas.ItemIndex:= -1;
      EdtValorDaConta.Text:= '0,00';
      EdtValorParcela.Text:= '0,00';
      DePagamento.Date:= StrToDate('01/01/2000');
      DeVencimento.Date:= Now;
      DePagamentoParcela.Date:= StrToDate('01/01/2000');
      DeVencimentoParcela.Date:= Now;
      EdtNomeConta.Text:= '';
      LstBxParcelasAPagar.Clear;
    end;
end;

function onlyNumber(Txt: string): string;
var
   I: Integer;
begin

  FrContasAPagar.Valor := '';

  for I := 1 to length(Txt) do
  begin
    if (Txt[I] in ['0' .. '9']) or (Txt[I] in [',','.']) then
    begin
      FrContasAPagar.Valor := FrContasAPagar.Valor + Txt[I];
    end;
  end;

  result := FrContasAPagar.Valor;

end;

procedure ConsultarContas(consComplete: string = '1');
var
   i: Integer;
begin

  with FrContasAPagar do
    begin

    if consComplete = '1' then
      begin
        Base.PesquisarContas(Acoes.checkToPar(RbTipoVencimento.IsChecked), DeInicioConsulta.Date, DeFimConsulta.Date);

        LstBxConsulta.Clear;

        FatoresPagar.ValorAtual1:= 0;
        FatoresPagar.ValorAtual2:= 0;

      for i := 0 to BaseResultadoConta.Count - 1 do
        begin
          ItemGrids.addConta(
                             LstBxConsulta,
                             BaseResultadoConta[i].CodigoConta,
                             BaseResultadoConta[i].Valor,
                             DateToStr(BaseResultadoConta[i].Pagamento),
                             DateToStr(BaseResultadoConta[i].Vencimento),
                             Inttostr(BaseResultadoConta[i].IdTabela),
                             BaseResultadoConta[i].Id);
        end;
      end;

      LblTotalContas.Text:= 'A PAGAR: R$ ' + FormatFloat('###,###,##0.00', FatoresPagar.ValorAtual1) + '  PAGO: R$ ' + FormatFloat('###,###,##0.00', FatoresPagar.ValorAtual2);
    end;
end;

procedure ConsultarParcelas(consComplete: string = '1');
var
   i: Integer;
begin

  with FrContasAPagar do
    begin

    if consComplete = '1' then
      begin
        LstBxParcelasAPagar.Clear;

        Base.PesquisarParcelas(BaseResultadoConta[itemConsultaPagar].IdTabela);

        FatoresParcelas.ValorAtual1:= 0;
        FatoresParcelas.ValorAtual2:= 0;

      for i := 0 to BaseResultadoParcela.Count - 1 do
        begin
          ItemGrids.addParcela(
                               LstBxParcelasAPagar,
                               EdtCodigoConta.Text,
                               FormatFloat('###,###,##0.00', BaseResultadoParcela[i].Valor),
                               DateToStr(BaseResultadoParcela[i].Pagamento),
                               DateToStr(BaseResultadoParcela[i].Vencimento),
                               Inttostr(BaseResultadoParcela[i].IdTabela),
                               BaseResultadoParcela[i].Id);
        end;
      end;

      LblParcelasAPagar.Text:= 'A PAGAR: R$ ' + FormatFloat('###,###,##0.00', FatoresParcelas.ValorAtual1);
      LblParcelasPagas.Text:= 'PAGO: R$ ' + FormatFloat('###,###,##0.00', FatoresParcelas.ValorAtual2);
    end;
end;

procedure AbreConsulta;
begin

  with FrContasAPagar do
    begin
      DeInicioConsulta.Date:= Now - 365;
      DeFimConsulta.Date:= Now;
      ConsultarContas;
    end;
end;

procedure configuraTela(state: Boolean);
begin

  with FrContasAPagar do
    begin

      ItemGrids.resetSearch;
      Permite_Alteracao           := state;
      SpBtDeletar.Enabled         := state;
      SpBtEditar.Enabled          := state;
      SpBtNovo.Enabled            := state;
      SpBtCancelar.Enabled        := not state;
      SpBtSalvarRegistro.Enabled  := not state;
      RctLancarParcela.Enabled    := not state;
      RctLancarConta.Enabled      := not state;
      Lanca_Parcela               := not state;

    if state then
      TbWork.TabIndex             := 2
    else
      TbWork.TabIndex             := 0
    end;
end;

{$ENDREGION}

{$R *.fmx}

{$REGION 'Ações de Edits'}

procedure TFrContasAPagar.CbTiposDeContasKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

  if key = 9 then
    begin
      EdtCodigoConta.SetFocus;
    end;
end;

procedure TFrContasAPagar.CbVencimentoDiaFixoChange(Sender: TObject);
begin
  if CbVencimentoDiaFixo.IsChecked = True then
    begin
      EdtVencimentoEmDiasParcelas.Visible:= False;
      LblVencimentoEmDias.Visible:= False;
      DeVencimentoEmDias.Visible:= False;
      CbVencimentoEmDias.IsChecked:= False;

      DeVencimentoDiaFixoParcela.Visible:= True;
      DeVencimentoDiaFixoParcela.Date:= now;
      LblVencimentoDiaFixo.Visible:= True;
      EdtVencimentoDiaFixoMes.Visible:= True;
    end
  else
    begin
      EdtVencimentoDiaFixoMes.Visible:= False;
      LblVencimentoDiaFixo.Visible:= False;
      DeVencimentoDiaFixoParcela.Visible:= False;
    end;
end;

procedure TFrContasAPagar.CbTiposDeContasExit(Sender: TObject);
begin
  if CbTiposDeContas.ItemIndex <> -1 then
    EdtCodigoConta.Text:= comboItemDespesa(CbTiposDeContas.Selected).CdDespesa;
end;

procedure TFrContasAPagar.CbVencimentoEmDiasChange(Sender: TObject);
begin

  if CbVencimentoEmDias.IsChecked = True then
    begin
      EdtVencimentoEmDiasParcelas.Visible:= True;
      LblVencimentoEmDias.Visible:= True;
      DeVencimentoEmDias.Visible:= True;
      DeVencimentoEmDias.Date:= now;

      EdtVencimentoDiaFixoMes.Visible:= False;
      LblVencimentoDiaFixo.Visible:= False;
      DeVencimentoDiaFixoParcela.Visible:= False;
      CbVencimentoDiaFixo.IsChecked:= False;
    end
  else
    begin
      DeVencimentoEmDias.Visible:= False;
      LblVencimentoEmDias.Visible:= False;
      EdtVencimentoEmDiasParcelas.Visible:= False;
    end;
end;

procedure TFrContasAPagar.DeFimConsultaExit(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAPagar.DeInicioConsultaExit(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAPagar.EdtNomeContaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

  if key = 9 then
    begin
      EdtValorDaConta.SetFocus;
    end;
end;

procedure TFrContasAPagar.EdtValorDaContaEnter(Sender: TObject);
begin
  if (StrToFloat(EdtValorDaConta.Text) = 0) then
    EdtValorDaConta.Text:= '';
end;

procedure TFrContasAPagar.EdtValorDaContaExit(Sender: TObject);
begin
  if (EdtValorDaConta.Text = '') then
     EdtValorDaConta.Text:= '0,00';
end;

procedure TFrContasAPagar.EdtValorDaContaKeyDown(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorDaConta.Text:= onlyNumber(EdtValorDaConta.Text);
end;

procedure TFrContasAPagar.EdtValorDaContaKeyUp(Sender: TObject; var Key: Word;
    var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorDaConta.Text:= onlyNumber(EdtValorDaConta.Text);
end;

procedure TFrContasAPagar.EdtValorParcelaEnter(Sender: TObject);
begin
  if (StrToFloat(EdtValorParcela.Text) = 0) then
    EdtValorParcela.Text:= '';
end;

procedure TFrContasAPagar.EdtValorParcelaExit(Sender: TObject);
begin
  if (EdtValorParcela.Text = '') then
    EdtValorParcela.Text:= '0,00';
end;

procedure TFrContasAPagar.EdtValorParcelaKeyDown(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorParcela.Text:= onlyNumber(EdtValorParcela.Text);
end;

procedure TFrContasAPagar.EdtValorParcelaKeyUp(Sender: TObject; var Key: Word;
    var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorParcela.Text:= onlyNumber(EdtValorParcela.Text);
end;

{$ENDREGION}

{$REGION 'Ações dos Atalhos'}

procedure TFrContasAPagar.FormKeyUp(Sender: TObject; var Key: Word; var
    KeyChar: Char; Shift: TShiftState);
begin
  ConsultarContas('0');

  if Key = 45 then // Enter - salvar parcela
    begin
      Botoes.Salvar('P');
    end
  else if Key = 113 then // F2 - Editar registro
    begin
      Botoes.Editar;
    end
  else if Key = 114 then //F3 - Abrir tela de consulta
    begin
      Botoes.Pesquisar;
    end
  else if Key = 115 then //F4 - Adicionar registro
    begin
      Botoes.Adicionar;
    end
  else if Key = 116 then //F5 - Salvar Registro
    begin
      Botoes.Salvar('R');
    end
  else if Key = 27 then //Esc - Cancelar ação
    begin
      Botoes.Cancelar;
    end
  else if Key = 46 then //Del - Apagar Registro
    begin
      Botoes.Excluir;
    end
  else if Key = 36 then //Home - Voltar para a Tela inicial
    begin
      FrContasAPagar.Close;
    end;
end;

procedure TFrContasAPagar.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  ConsultarContas('0');
end;

{$ENDREGION}

{$REGION 'Ações do Formulário'}

procedure TFrContasAPagar.FormShow(Sender: TObject);
begin
  RctLancarParcela.Enabled                 := False;
  RctLancarConta.Enabled                   := False;
  configuraTela(True);
  Permite_Alteracao                        := True;
  TbWork.TabIndex                          := 2;
  stp                                      := 'PG';
  Lanca_Parcela:= false;
  CbVencimentoEmDiasChange(sender);
  CbVencimentoDiaFixoChange(sender);
  Limparcampos;
  AbreConsulta;
  Base.PreencheContas(CbTiposDeContas);

end;

procedure TFrContasAPagar.FormActivate(Sender: TObject);
begin
  ConsultarContas('0');
end;

procedure TFrContasAPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Botoes.Cancelar;
end;

procedure TFrContasAPagar.FormCreate(Sender: TObject);
begin
  FatoresPagar:= TFatores.Create;
  Acoes:= TAcoes.Create;
  FatoresParcelas:= TFatores.Create;
end;

{$ENDREGION}

{$REGION 'Ações dos Botões'}

procedure TFrContasAPagar.ImgBtCloseApplicationClick(Sender: TObject);
begin
  Botoes.Cancelar;
  FrContasAPagar.Close;
end;

procedure TFrContasAPagar.LstBxConsultaGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  ConsultarContas('0');
end;

procedure TFrContasAPagar.LstBxConsultaMouseEnter(Sender: TObject);
begin
  ConsultarContas('0');
end;

procedure TFrContasAPagar.LstBxConsultaMouseLeave(Sender: TObject);
begin
  ConsultarContas('0');
end;

procedure TFrContasAPagar.LstBxConsultaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  ConsultarContas('0');
end;

procedure TFrContasAPagar.LstBxConsultaMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  ConsultarContas('0');
end;

procedure TFrContasAPagar.LstBxParcelasAPagarGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  ConsultarParcelas('0');
end;

procedure TFrContasAPagar.LstBxParcelasAPagarMouseEnter(Sender: TObject);
begin
  ConsultarParcelas('0');
end;

procedure TFrContasAPagar.LstBxParcelasAPagarMouseLeave(Sender: TObject);
begin
  ConsultarParcelas('0');
end;

procedure TFrContasAPagar.LstBxParcelasAPagarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
begin
  ConsultarParcelas('0');
end;

procedure TFrContasAPagar.LstBxParcelasAPagarMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  ConsultarParcelas('0');
end;

procedure TFrContasAPagar.RbTipoPagamentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAPagar.RbTipoVencimentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAPagar.SpBtAbaDadosDaContaClick(Sender: TObject);
begin
  Tbwork.TabIndex:= 0;
end;

procedure TFrContasAPagar.SpBtConsultar_2Click(Sender: TObject);
begin
  Botoes.Pesquisar;
end;

procedure TFrContasAPagar.SpBtConsultar_1Click(Sender: TObject);
begin
  Botoes.Pesquisar;
end;

procedure TFrContasAPagar.SpBtConsultar_0Click(Sender: TObject);
begin
  Botoes.Pesquisar;
end;

procedure TFrContasAPagar.SpBtSalvarRegistroClick(Sender: TObject);
begin
  Botoes.Salvar('R');
end;

procedure TFrContasAPagar.SpBtAdicionarParcelaClick(Sender: TObject);
begin
  Botoes.Salvar('P');
end;

procedure TFrContasAPagar.SpBtCancelarClick(Sender: TObject);
begin
  Botoes.Cancelar;
end;

procedure TFrContasAPagar.SpBtDeletarClick(Sender: TObject);
begin
  Botoes.Excluir;
end;

procedure TFrContasAPagar.SpBtEditarClick(Sender: TObject);
begin
  Botoes.Editar;
end;

procedure TFrContasAPagar.SpBtGerarParcelasClick(Sender: TObject);
var
   QtdParcelas, i: Integer;
   VlrParcela: Double;
   Vencimento: string;
begin
  QtdParcelas:= StrToInt(EdtQtdParcelas.Text);
  VlrParcela:= StrToFloat(EdtValorDaConta.Text) / QtdParcelas;

  for i := 0 to QtdParcelas do
    begin


    end;
end;

procedure TFrContasAPagar.SpBtNovoClick(Sender: TObject);
begin
  Botoes.Adicionar;
end;

procedure TFrContasAPagar.SpBtAbaParcelasClick(Sender: TObject);
begin
  Tbwork.TabIndex:= 1;
end;

{$ENDREGION}

{$REGION 'Comandos a serem executados nas ações de CRUD'}

procedure navBar.Adicionar;
begin
  with FrContasAPagar do
    begin
      NovoOuEdita:= 'N';
      configuraTela(False);
      Limparcampos;
    end;
end;

procedure navBar.Cancelar;
begin
  with FrContasAPagar do
    begin
      Limparcampos;
      NovoOuEdita:= '';
      configuraTela(True);
      ConsultarContas;
    end;
end;

procedure navBar.Editar;
var
   chave: Integer;
begin
  with FrContasAPagar do
    begin
      NovoOuEdita:= 'E';
      configuraTela(False);

      chave := itemConsultaPagar;

      Desp.despToCbxItem(CbTiposDeContas, BaseResultadoConta[chave].Despesa);
      EdtValorDaConta.Text       := FormatFloat(formatoValor, BaseResultadoConta[chave].Valor);
      DePagamento.Date           := BaseResultadoConta[chave].Pagamento;
      DeVencimento.Date          := BaseResultadoConta[chave].Vencimento;
      chaveRegistroEdicao        := BaseResultadoConta[chave].IdTabela;

      EdtCodigoConta.Text        := Copy(BaseResultadoConta[chave].CodigoConta, 0, length(comboItemDespesa(CbTiposDeContas.Selected).CdDespesa));
      EdtNomeConta.Text          := Copy(BaseResultadoConta[chave].CodigoConta, length(comboItemDespesa(CbTiposDeContas.Selected).CdDespesa) + 4, length(BaseResultadoConta[chave].CodigoConta) - length(comboItemDespesa(CbTiposDeContas.Selected).CdDespesa) - 4);

      LstBxParcelasAPagar.Clear;
      ConsultarParcelas;
    end;
end;

procedure navBar.Excluir;
begin
  with FrContasAPagar do
    begin

    if Permite_Alteracao = True then
      begin

      if A.mensagemAlerta('', 'Confirma Exclusão?', 1) = True then
        begin
          LstBxConsulta.Clear;
          Base.DeletaConta(BaseResultadoConta[itemConsultaPagar].IdTabela);
          Cancelar;
        end
      else
        begin
          A.mensagemAlerta('', 'Operação Cancelada', 0);
        end;
      end
    else
      begin
        E.mensagemErro('Impossível concluir operação',
                       'Não é possível chamar a operação de exclusão no momento. Sua operação atual foi cancelada', 0);
        Cancelar;
      end;
    end;
end;

procedure navBar.Pesquisar;
begin
  with FrContasAPagar do
    begin

    if TbWork.TabIndex <> 2 then
      begin
      if Permite_Alteracao = False then
        begin

        if A.mensagemAlerta('', 'Certeza? Sua operação atual será cancelada', 1) = True then
          begin
            TbWork.TabIndex:= 2;
            LstBxConsulta.Clear;
            Cancelar;
          end
        else
          begin
            Permite_Alteracao                   := True;
          end;
        end
      else
        begin
          TbWork.TabIndex:= 2;
          ConsultarContas;
          configuraTela(True);
        end;
      end
    else
      begin
        ConsultarContas;
        configuraTela(True);
      end;
    end;
end;

procedure navBar.Salvar(tp: string);
var
   conta: string;
begin
  with FrContasAPagar do
    begin

    if tp = 'P' then
      begin

      if Lanca_Parcela = True then
        begin

        if (StrToFloat(EdtValorParcela.Text) <> 0) and (EdtNomeConta.Text <> '') then
          begin

          if NovoOuEdita = 'N' then else
            Base.SalvaParcela(BaseResultadoConta[itemConsultaPagar].IdTabela, StrToFloat(EdtValorParcela.Text), DePagamentoParcela.Date, DePagamentoParcela.Date, '');

            LstBxParcelasAPagar.Clear;
            ConsultarParcelas;

            LblParcelasAPagar.Text:= 'A PAGAR: R$ ' + FormatFloat('###,###,##0.00', FatoresParcelas.ValorAtual1);
            LblParcelasPagas.Text:= 'PAGO: R$ ' + FormatFloat('###,###,##0.00', FatoresParcelas.ValorAtual2);

            EdtValorParcela.Text:= '0,00';
          end
        else
          begin

          if StrToFloat(EdtValorParcela.Text) = 0 then
            begin
              E.mensagemErro('VALOR INVÁLIDO', 'VOCÊ NÃO PODE GERAR UMA PARCELA SEM VALOR!!', 0);

              EdtValorParcela.SetFocus;
            end
          else
            begin
              E.mensagemErro('SEM CONTA', 'VOCÊ NÃO PODE GERAR UMA PARCELA SEM UMA CONTA!!!', 0);
              EdtNomeConta.SetFocus;
            end;
          end;
        end;
      end
    else if Permite_Alteracao = False then
      begin

        conta:= EdtCodigoConta.Text + ' ( ' + EdtNomeConta.Text + ' )';

      if A.mensagemAlerta('', 'Confirma Salvamento?', 1) = True then
        begin

        if NovoOuEdita = 'N' then
          Base.SalvaConta(conta, StrToFloat(EdtValorDaConta.Text), DePagamento.Date, DeVencimento.Date, comboItemDespesa(CbTiposDeContas.Selected).Id, '')
        else
          Base.SalvaConta(conta, StrToFloat(EdtValorDaConta.Text), DePagamento.Date, DeVencimento.Date, comboItemDespesa(CbTiposDeContas.Selected).Id, '', BaseResultadoConta[itemConsultaPagar].IdTabela);

          configuraTela(True);
          LstBxConsulta.Clear;
          Cancelar;
          Limparcampos;
        end
      else
        begin
          A.mensagemAlerta('', 'Operação Cancelada', 0);
        end;
      end;
    end;
end;
{$ENDREGION}

end.
