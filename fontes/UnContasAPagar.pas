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
  UnControleErros;

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
    RctPnlNav: TRectangle;
    ImgBtCloseApplication: TImage;
    anHoverBtClose: TFloatAnimation;
    anUnhoverBtClose: TFloatAnimation;
    LblTituloTela: TLabel;
    RctPnlWorkShp: TRectangle;
    TbWork: TTabControl;
    TbItLancamento: TTabItem;
    GpParcelasReceber: TGroupBox;
    RctDadosParcela: TRectangle;
    RctValorParcela: TRectangle;
    EdtValorParcela: TEdit;
    LblValorParcela: TLabel;
    RctBotoesLancaParcela: TRectangle;
    SpBtAdicionarParcela: TSpeedButton;
    ImgBtParcelas: TImage;
    LblBtParcelas: TLabel;
    GpLancamentoParcela: TGroupBox;
    DeLancamentoParcela: TDateEdit;
    LstBxParcelasAPagar: TListBox;
    RctWork: TRectangle;
    RctPnlNavLancarServico: TRectangle;
    SpBtNovo: TSpeedButton;
    ImgBtNovo: TImage;
    LblBtNovo: TLabel;
    SpBtEditar: TSpeedButton;
    LblBtEditar: TLabel;
    ImgBtEditar: TImage;
    SpBtDeletar: TSpeedButton;
    LblBtDeletar: TLabel;
    ImgBtDeletar: TImage;
    SpBtCancelar: TSpeedButton;
    ImgBtCancelar: TImage;
    LblBtCancelar: TLabel;
    RctWorkSpace: TRectangle;
    GpDatasLancamento: TGroupBox;
    DePagamento: TDateEdit;
    LblDataPagamento: TLabel;
    LblDataVencimento: TLabel;
    DeVencimento: TDateEdit;
    GdLytNomeConta: TGridLayout;
    LblNomeConta: TLabel;
    EdtNomeConta: TEdit;
    GdLytInformacoesBase: TGridLayout;
    LblTipoConta: TLabel;
    CbTiposDeContas: TComboBox;
    LblValorConta: TLabel;
    EdtValorDaConta: TEdit;
    LblDicasAtalhosLancamentos: TLabel;
    TbItConsulta: TTabItem;
    RctConsulta: TRectangle;
    RctFiltrosConsulta: TRectangle;
    LblTTAPagar: TLabel;
    LblTTPagas: TLabel;
    GpPeriodoConsulta: TGroupBox;
    DeInicioConsulta: TDateEdit;
    LblPeriodoPesquisaDe: TLabel;
    LblPeriodoPesquisaAte: TLabel;
    DeFimConsulta: TDateEdit;
    RbTipoPagamento: TRadioButton;
    RbTipoVencimento: TRadioButton;
    LblDicasAtalhosPesquisa: TLabel;
    LstBxConsulta: TListBox;

    {$ENDREGION}

    {$REGION 'Declaração das procedures e variáveis da tela'}

    procedure CbTiposDeContasChange(Sender: TObject);
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
    procedure ImgBtCloseApplicationMouseEnter(Sender: TObject);
    procedure ImgBtCloseApplicationMouseLeave(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
        TShiftState);
    procedure FormShow(Sender: TObject);
    procedure RbTipoPagamentoChange(Sender: TObject);
    procedure RbTipoVencimentoChange(Sender: TObject);
    procedure SpBtAdicionarParcelaClick(Sender: TObject);
    procedure SpBtCancelarClick(Sender: TObject);
    procedure SpBtDeletarClick(Sender: TObject);
    procedure SpBtEditarClick(Sender: TObject);
    procedure SpBtNovoClick(Sender: TObject);

  private
    Parcela: ItemGrids;
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
      DePagamento.Date:= Now;
      DeVencimento.Date:= Now;
      DeLancamentoParcela.Date:= now;
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

procedure ConsultarContas;
var
   i: Integer;
   Pagas, APagar: Double;
begin

  with FrContasAPagar do
    begin
      Pagas:= 0;
      APagar:= 0;
      LstBxConsulta.Clear;

    if RbTipoVencimento.IsChecked then
      TipodatConsulta:= 0
    else
      TipodatConsulta:= 1;

      Base.PesquisarContas(TipodatConsulta, DeInicioConsulta.Date, DeFimConsulta.Date);

    for i := 0 to BaseResultadoConta.Count - 1 do
      begin
        Parcela.addConta(
                         LstBxConsulta,
                         BaseResultadoConta[i].CodigoConta,
                         FormatFloat('###,###,##0.00', BaseResultadoConta[i].Valor),
                         DateToStr(BaseResultadoConta[i].Vencimento),
                         DateToStr(BaseResultadoConta[i].Pagamento),
                         BaseResultadoConta[i].Id);

      if DateToStr(BaseResultadoConta[i].Pagamento) <> '01/01/2000' then
        Pagas:= Pagas + BaseResultadoConta[i].Valor
      else
        APagar:= APagar + BaseResultadoConta[i].Valor;
      end;

      LblTTAPagar.Text:= 'A PAGAR: R$ ' + FormatFloat('###,###,##0.00', APagar);
      LblTTPagas.Text:= 'PAGO: R$ ' + FormatFloat('###,###,##0.00',Pagas);
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

      Parcela.resetSearch;
      Permite_Alteracao           := state;
      SpBtDeletar.Enabled         := state;
      SpBtEditar.Enabled          := state;
      SpBtNovo.Enabled            := state;
      SpBtCancelar.Enabled        := not state;
      RctWorkSpace.Enabled        := not state;
//      GpParcelasReceber.Enabled   := not state;
      Lanca_Parcela               := not state;

    if state then
      TbWork.TabIndex             := 1
    else
      TbWork.TabIndex             := 0
    end;
end;

{$ENDREGION}

{$R *.fmx}

{$REGION 'Ações de Edits'}

procedure TFrContasAPagar.CbTiposDeContasChange(Sender: TObject);
begin
//  EdtNomeConta.Text:= '';
end;

procedure TFrContasAPagar.DeFimConsultaExit(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAPagar.DeInicioConsultaExit(Sender: TObject);
begin
  ConsultarContas;
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
  {if Key = 13 then // Enter - salvar parcela
    begin
      Botoes.Salvar('P');
    end
  else} if Key = 113 then // F2 - Editar registro
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

{$ENDREGION}

{$REGION 'Ações do Formulário'}

procedure TFrContasAPagar.FormShow(Sender: TObject);
begin
  RctWorkSpace.Enabled                     := False;
//  GpParcelasReceber.Enabled                := False;
  Permite_Alteracao                        := True;
  TbWork.TabIndex                          := 1;
  Limparcampos;
  AbreConsulta;
  Base.PreencheContas(CbTiposDeContas);
end;

procedure TFrContasAPagar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Botoes.Cancelar;
end;


{$ENDREGION}

{$REGION 'Ações dos Botões'}

procedure TFrContasAPagar.ImgBtCloseApplicationClick(Sender: TObject);
begin
  Botoes.Cancelar;
  FrContasAPagar.Close;
end;

procedure TFrContasAPagar.ImgBtCloseApplicationMouseEnter(Sender: TObject);
begin
  anHoverBtClose.Start;
end;

procedure TFrContasAPagar.ImgBtCloseApplicationMouseLeave(Sender: TObject);
begin
  anUnhoverBtClose.Start;
end;

procedure TFrContasAPagar.RbTipoPagamentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAPagar.RbTipoVencimentoChange(Sender: TObject);
begin
  ConsultarContas;
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

procedure TFrContasAPagar.SpBtNovoClick(Sender: TObject);
begin
  Botoes.Adicionar;
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

      CbTiposDeContas.ItemIndex  := BaseResultadoConta[chave].Despesa;
      EdtValorDaConta.Text       := FormatFloat(formatoValor, BaseResultadoConta[chave].Valor);
      DePagamento.Date           := BaseResultadoConta[chave].Pagamento;
      DeVencimento.Date          := BaseResultadoConta[chave].Vencimento;
      EdtNomeConta.Text          := BaseResultadoConta[chave].CodigoConta;
      chaveRegistroEdicao        := BaseResultadoConta[chave].IdTabela;

      LstBxParcelasAPagar.Clear;
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

    if Permite_Alteracao = False then
      begin

      if A.mensagemAlerta('', 'Certeza? Sua operação atual será cancelada', 1) = True then
        begin
          LstBxConsulta.Clear;
          Cancelar;
        end
      else
        begin
          Permite_Alteracao                   := True;
        end;
      end;
    end;
end;

procedure navBar.Salvar(tp: string);
begin
  with FrContasAPagar do
    begin

    if tp = 'P' then
      begin

      if Lanca_Parcela = True then
        begin

        if (StrToFloat(EdtValorParcela.Text) <> 0) and (EdtNomeConta.Text <> '') then
          begin
            Parcela.addParcela(LstBxParcelasAPagar, EdtNomeConta.Text, DeLancamentoParcela.Text, EdtValorParcela.Text);
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

      if A.mensagemAlerta('', 'Confirma Salvamento?', 1) = True then
        begin

        if NovoOuEdita = 'N' then
          Base.SalvaConta(EdtNomeConta.Text, StrToFloat(EdtValorDaConta.Text), DePagamento.Date, DeVencimento.Date, integer(CbTiposDeContas.Items.Objects[CbTiposDeContas.ItemIndex]), '')
        else
          Base.SalvaConta(EdtNomeConta.Text, StrToFloat(EdtValorDaConta.Text), DePagamento.Date, DeVencimento.Date, integer(CbTiposDeContas.Items.Objects[CbTiposDeContas.ItemIndex]), '', BaseResultadoConta[itemConsultaPagar].IdTabela);

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
