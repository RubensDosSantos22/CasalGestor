unit UnContasAReceber;

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
  UnDBcontasAReceber,
  UnFrmItensContas,
  UnControleErros,
  UnDBcadastros;

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

  TFrContasAReceber = class(TForm)

    {$REGION 'Declaração dos compoenntes da tela'}
    ImgBackground: TImage;
    RctPnlTituloTela: TRectangle;
    LytTituloTela: TLayout;
    LblTituloTela: TLabel;
    ImgIconeTela: TImage;
    SpBtAjuda: TSpeedButton;
    ImgBtAjuda: TImage;
    GdLytNavBotoesTela: TGridLayout;
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
    RctPnlWorkShp: TRectangle;
    TbWork: TTabControl;
    TbItLancamento: TTabItem;
    RctLancarConta: TRectangle;
    RctDadosConta: TRectangle;
    LytNomeConta: TLayout;
    LblNomeConta: TLabel;
    EdtCodigoConta: TEdit;
    EdtNomeConta: TEdit;
    LytDatas: TLayout;
    LblDataPagamento: TLabel;
    DePagamento: TDateEdit;
    LblDataVencimento: TLabel;
    DeVencimento: TDateEdit;
    LytInformacoesPrincipais: TLayout;
    LblTipoConta: TLabel;
    CbTiposDeContas: TComboBox;
    EdtValorDaConta: TEdit;
    LblValorConta: TLabel;
    LytRodapeLancamento: TLayout;
    RctBtAbaParcelas: TRectangle;
    SpBtAbaParcelas: TSpeedButton;
    ImgBtAbaParcelasL: TImage;
    LblBtAbaParcelas: TLabel;
    ImgBtAbaParcelasR: TImage;
    LytLancamento: TLayout;
    LblLancamento: TLabel;
    ImgLancamento: TImage;
    RctBtConsultar_0: TRectangle;
    SpBtConsultar_0: TSpeedButton;
    ImgBtConsultar_0L: TImage;
    LblConsultar_0: TLabel;
    ImgBtConsultar_0R: TImage;
    TbItParcelas: TTabItem;
    RctLancarParcela: TRectangle;
    RctDadosDaParcela: TRectangle;
    LytLancarUmaParcela: TLayout;
    LblPagamentoParcela: TLabel;
    DePagamentoParcela: TDateEdit;
    DeVencimentoParcela: TDateEdit;
    LblVencimentoParcela: TLabel;
    EdtValorParcela: TEdit;
    LblValorParcela: TLabel;
    RctBtAdicionarParcela: TRectangle;
    SpBtAdicionarParcela: TSpeedButton;
    ImgBtParcelas: TImage;
    LblBtParcelas: TLabel;
    LytLancarVariasParcelas: TLayout;
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
    Img16: TImage;
    LytVencimentoEmDiasCorridos: TLayout;
    CbVencimentoEmDias: TCheckBox;
    EdtVencimentoEmDiasParcelas: TEdit;
    LblVencimentoEmDias: TLabel;
    DeVencimentoEmDias: TDateEdit;
    LytParcelamentoPorDiaFIxo: TLayout;
    CbVencimentoDiaFixo: TCheckBox;
    DeVencimentoDiaFixoParcela: TDateEdit;
    LblVencimentoDiaFixo: TLabel;
    EdtVencimentoDiaFixoMes: TEdit;
    LytRodapeParcela: TLayout;
    RctBtAbaDadosDaConta: TRectangle;
    SpBtAbaDadosDaConta: TSpeedButton;
    ImgBtAbaDadosDaContaL: TImage;
    LblBtAbaDadosDaConta: TLabel;
    ImgBtAbaDadosDaContaR: TImage;
    LytParcelas: TLayout;
    LblParcelas: TLabel;
    ImgParcelas: TImage;
    RctBtConsultar_1: TRectangle;
    SpBtConsultar_1: TSpeedButton;
    ImgBtConsultar_1L: TImage;
    LblBtConsultar_1: TLabel;
    ImgBtConsultar_1R: TImage;
    TbItConsulta: TTabItem;
    RctConsulta: TRectangle;
    LstBxConsulta: TListBox;
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
    LytConsultar: TLayout;
    LblConsultar: TLabel;
    ImgIconeConsultar: TImage;
    RctBtConsultar: TRectangle;
    SpBtConsultar_2: TSpeedButton;
    ImgBtConsultar_2: TImage;
    LblBtConsultar_2: TLabel;
    Lbl1: TLabel;

    {$ENDREGION}

    {$REGION 'Declaração das procedures e variáveis da tela'}

    procedure EdtValorDaContaKeyDown(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure EdtValorDaContaKeyUp(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure EdtValorParcelaEnter(Sender: TObject);
    procedure EdtValorParcelaKeyDown(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure EdtValorParcelaKeyUp(Sender: TObject; var Key: Word; var KeyChar:
        Char; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift:
        TShiftState);
    procedure ImgBtCloseApplicationClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpBtAdicionarParcelaClick(Sender: TObject);
    procedure SpBtCancelarClick(Sender: TObject);
    procedure SpBtDeletarClick(Sender: TObject);
    procedure SpBtEditarClick(Sender: TObject);
    procedure SpBtNovoClick(Sender: TObject);
    procedure DeFimConsultaExit(Sender: TObject);
    procedure CbTiposDeContasExit(Sender: TObject);
    procedure DeInicioConsultaExit(Sender: TObject);
    procedure EdtValorDaContaExit(Sender: TObject);
    procedure EdtValorParcelaExit(Sender: TObject);
    procedure RbTipoPagamentoChange(Sender: TObject);
    procedure RbTipoVencimentoChange(Sender: TObject);
    procedure SpBtAbaDadosDaContaClick(Sender: TObject);
    procedure SpBtAbaParcelasClick(Sender: TObject);
    procedure SpBtConsultar_0Click(Sender: TObject);
    procedure SpBtConsultar_1Click(Sender: TObject);
    procedure SpBtConsultar_2Click(Sender: TObject);
    procedure SpBtSalvarRegistroClick(Sender: TObject);

  private
    Parcela: TItemGrids;
    Botoes: Navbar;
    TipodatConsulta, chaveRegistroEdicao: Integer;
  public
    Lanca_Parcela, Permite_Alteracao: Boolean;
    Valor: string;
    NovoOuEdita: string;

    {$ENDREGION}

  end;

var
   Base: DBReceber;
   E: Erro;
   A: Aviso;
   formatoValor: string = '###,###,##0.00';

var
  FrContasAReceber: TFrContasAReceber;

{$ENDREGION}

implementation

uses
    UnFrmErrosSistema;

{$REGION 'Ações extras do Formulário'}

procedure Limparcampos;
begin

  with FrContasAReceber do
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

  FrContasAReceber.Valor := '';

  for I := 1 to length(Txt) do
  begin
    if (Txt[I] in ['0' .. '9']) or (Txt[I] in [',','.']) then
    begin
      FrContasAReceber.Valor := FrContasAReceber.Valor + Txt[I];
    end;
  end;

  result := FrContasAReceber.Valor;

end;

procedure ConsultarContas;
var
   i: Integer;
   Pagas, APagar: Double;
begin

  with FrContasAReceber do
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
                         BaseResultadoConta[i].Valor,
                         DateToStr(BaseResultadoConta[i].Vencimento),
                         DateToStr(BaseResultadoConta[i].Recebimento),
                         Inttostr(BaseResultadoConta[i].IdTabela),
                         BaseResultadoConta[i].Id);

      if DateToStr(BaseResultadoConta[i].Recebimento) <> '01/01/2000' then
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

  with FrContasAReceber do
    begin
      DeInicioConsulta.Date:= Now - 365;
      DeFimConsulta.Date:= Now;
      ConsultarContas;
    end;
end;

procedure configuraTela(state: Boolean);
begin

  with FrContasAReceber do
    begin

      Parcela.resetSearch;
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

procedure TFrContasAReceber.CbTiposDeContasExit(Sender: TObject);
begin
  if CbTiposDeContas.ItemIndex <> -1 then
    EdtCodigoConta.Text:= comboItemReceita(CbTiposDeContas.Selected).CdReceita;
end;

procedure TFrContasAReceber.DeFimConsultaExit(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAReceber.DeInicioConsultaExit(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAReceber.EdtValorDaContaExit(Sender: TObject);
begin
  if (EdtValorDaConta.Text = '') then
     EdtValorDaConta.Text:= '0,00';
end;

procedure TFrContasAReceber.EdtValorDaContaKeyDown(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorDaConta.Text:= onlyNumber(EdtValorDaConta.Text);
end;

procedure TFrContasAReceber.EdtValorDaContaKeyUp(Sender: TObject; var Key: Word;
    var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorDaConta.Text:= onlyNumber(EdtValorDaConta.Text);
end;

procedure TFrContasAReceber.EdtValorParcelaEnter(Sender: TObject);
begin
  if (StrToFloat(EdtValorParcela.Text) = 0) then
    EdtValorParcela.Text:= '';
end;

procedure TFrContasAReceber.EdtValorParcelaExit(Sender: TObject);
begin
  if (EdtValorParcela.Text = '') then
    EdtValorParcela.Text:= '0,00';
end;

procedure TFrContasAReceber.EdtValorParcelaKeyDown(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorParcela.Text:= onlyNumber(EdtValorParcela.Text);
end;

procedure TFrContasAReceber.EdtValorParcelaKeyUp(Sender: TObject; var Key: Word;
    var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorParcela.Text:= onlyNumber(EdtValorParcela.Text);
end;

{$ENDREGION}

{$REGION 'Ações dos Atalhos'}

procedure TFrContasAReceber.FormKeyUp(Sender: TObject; var Key: Word; var
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
      FrContasAReceber.Close;
    end;
end;

{$ENDREGION}

{$REGION 'Ações do Formulário'}

procedure TFrContasAReceber.FormShow(Sender: TObject);
begin
  RctLancarParcela.Enabled                 := False;
  RctLancarConta.Enabled                   := False;
  Permite_Alteracao                        := True;
  TbWork.TabIndex                          := 2;
  stp                                      := 'RCB';
  configuraTela(True);
  Limparcampos;
  AbreConsulta;
  Base.PreencheContas(CbTiposDeContas);
end;

procedure TFrContasAReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Botoes.Cancelar;
end;


{$ENDREGION}

{$REGION 'Ações dos Botões'}

procedure TFrContasAReceber.ImgBtCloseApplicationClick(Sender: TObject);
begin
  Botoes.Cancelar;
  FrContasAReceber.Close;
end;

procedure TFrContasAReceber.RbTipoPagamentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAReceber.RbTipoVencimentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAReceber.SpBtAbaDadosDaContaClick(Sender: TObject);
begin
  TbWork.TabIndex:= 0;
end;

procedure TFrContasAReceber.SpBtAbaParcelasClick(Sender: TObject);
begin
  TbWork.TabIndex:= 1;
end;

procedure TFrContasAReceber.SpBtAdicionarParcelaClick(Sender: TObject);
begin
  Botoes.Salvar('P');
end;

procedure TFrContasAReceber.SpBtCancelarClick(Sender: TObject);
begin
  Botoes.Cancelar;
end;

procedure TFrContasAReceber.SpBtConsultar_0Click(Sender: TObject);
begin
  Botoes.Pesquisar;
end;

procedure TFrContasAReceber.SpBtConsultar_1Click(Sender: TObject);
begin
  Botoes.Pesquisar;
end;

procedure TFrContasAReceber.SpBtConsultar_2Click(Sender: TObject);
begin
  Botoes.Pesquisar;
end;

procedure TFrContasAReceber.SpBtDeletarClick(Sender: TObject);
begin
  Botoes.Excluir;
end;

procedure TFrContasAReceber.SpBtEditarClick(Sender: TObject);
begin
  Botoes.Editar;
end;

procedure TFrContasAReceber.SpBtNovoClick(Sender: TObject);
begin
  Botoes.Adicionar;
end;

procedure TFrContasAReceber.SpBtSalvarRegistroClick(Sender: TObject);
begin
  Botoes.Salvar('R');
end;

{$ENDREGION}

{$REGION 'Comandos a serem executados nas ações de CRUD'}

procedure navBar.Adicionar;
begin
  with FrContasAReceber do
    begin
      NovoOuEdita:= 'N';
      configuraTela(False);
      Limparcampos;
    end;
end;

procedure navBar.Cancelar;
begin
  with FrContasAReceber do
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
  with FrContasAReceber do
    begin
      NovoOuEdita:= 'E';
      configuraTela(False);

      chave := itemConsultaPagar;

      Rec.receToCbxItem(CbTiposDeContas, BaseResultadoConta[chave].Receita);
      EdtValorDaConta.Text       := FormatFloat(formatoValor, BaseResultadoConta[chave].Valor);
      DePagamento.Date           := BaseResultadoConta[chave].Recebimento;
      DeVencimento.Date          := BaseResultadoConta[chave].Vencimento;
      chaveRegistroEdicao        := BaseResultadoConta[chave].IdTabela;

      EdtCodigoConta.Text        := Copy(BaseResultadoConta[chave].CodigoConta, 0, length(comboItemReceita(CbTiposDeContas.Selected).CdReceita));
      EdtNomeConta.Text          := Copy(BaseResultadoConta[chave].CodigoConta, length(comboItemReceita(CbTiposDeContas.Selected).CdReceita) + 4, length(BaseResultadoConta[chave].CodigoConta) - length(comboItemReceita(CbTiposDeContas.Selected).CdReceita) - 4);

      LstBxParcelasAPagar.Clear;
    end;
end;

procedure navBar.Excluir;
begin
  with FrContasAReceber do
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
        Cancelar;
        E.mensagemErro('Impossível concluir operação',
                       'Não é possível chamar a operação de exclusão no momento. Sua operação atual foi cancelada', 0);
      end;
    end;
end;

procedure navBar.Pesquisar;
begin
  with FrContasAReceber do
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
  with FrContasAReceber do
    begin

    if tp = 'P' then
      begin

      if Lanca_Parcela = True then
        begin

        if (StrToFloat(EdtValorParcela.Text) <> 0) and (EdtNomeConta.Text <> '') then
          begin
            //Parcela.addParcela(LstBxParcelasAPagar, EdtNomeConta.Text, DePagamentoParcela.Text, DeVencimentoParcela.Text, EdtValorParcela.Text);
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
          Base.SalvaConta(conta, StrToFloat(EdtValorDaConta.Text), DePagamento.Date, DeVencimento.Date, comboItemReceita(CbTiposDeContas.Selected).Id, '')
        else
          Base.SalvaConta(conta, StrToFloat(EdtValorDaConta.Text), DePagamento.Date, DeVencimento.Date, comboItemReceita(CbTiposDeContas.Selected).Id, '', BaseResultadoConta[itemConsultaPagar].IdTabela);

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
