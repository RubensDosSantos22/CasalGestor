unit UnContasAReceber;

interface

{$REGION 'Declara��es'}

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

  vcl.Dialogs,

  LibControlGrids, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,

  UnDBcontasAReceber, UnFrmItensContas, UnControleErros;

    {$ENDREGION}

type
    {$REGION 'fun��o do cabe�alho de bot�es'}

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

    {$REGION 'Declara��o dos compoenntes da tela'}
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

    {$REGION 'Declara��o das procedures e vari�veis da tela'}

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
    procedure ImgBtCloseApplicationMouseEnter(Sender: TObject);
    procedure ImgBtCloseApplicationMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpBtAdicionarParcelaClick(Sender: TObject);
    procedure SpBtCancelarClick(Sender: TObject);
    procedure SpBtDeletarClick(Sender: TObject);
    procedure SpBtEditarClick(Sender: TObject);
    procedure SpBtNovoClick(Sender: TObject);
    procedure DeFimConsultaExit(Sender: TObject);
    procedure CbTiposDeContasChange(Sender: TObject);
    procedure DeInicioConsultaExit(Sender: TObject);
    procedure EdtValorDaContaExit(Sender: TObject);
    procedure EdtValorParcelaExit(Sender: TObject);
    procedure RbTipoPagamentoChange(Sender: TObject);
    procedure RbTipoVencimentoChange(Sender: TObject);

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
   Base: DBReceber;
   E: Erro;
   A: Aviso;

var
  FrContasAReceber: TFrContasAReceber;

{$ENDREGION}

implementation

uses
    UnFrmErrosSistema;

{$REGION 'A��es extras do Formul�rio'}

procedure Limparcampos;
begin

  with FrContasAReceber do
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
                         FormatFloat('###,###,##0.00', BaseResultadoConta[i].Valor),
                         DateToStr(BaseResultadoConta[i].Vencimento),
                         DateToStr(BaseResultadoConta[i].Recebimento),
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

{$ENDREGION}

{$R *.fmx}


{$REGION 'A��es de Edits'}

procedure TFrContasAReceber.CbTiposDeContasChange(Sender: TObject);
begin
  EdtNomeConta.Text:= '';
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

{$REGION 'A��es dos Atalhos'}

procedure TFrContasAReceber.FormKeyUp(Sender: TObject; var Key: Word; var
    KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then // Enter - salvar parcela
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
  else if Key = 27 then //Esc - Cancelar a��o
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

{$REGION 'A��es do Formul�rio'}

procedure TFrContasAReceber.FormShow(Sender: TObject);
begin
  RctWorkSpace.Enabled                     := False;
  GpParcelasReceber.Enabled                := False;
  Permite_Alteracao                        := True;
  TbWork.TabIndex                          := 1;
  Limparcampos;
  AbreConsulta;
  Base.PreencheContas(CbTiposDeContas);
end;

procedure TFrContasAReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Botoes.Cancelar;
end;


{$ENDREGION}

{$REGION 'A��es dos Bot�es'}

procedure TFrContasAReceber.ImgBtCloseApplicationClick(Sender: TObject);
begin
  Botoes.Cancelar;
  FrContasAReceber.Close;
end;

procedure TFrContasAReceber.ImgBtCloseApplicationMouseEnter(Sender: TObject);
begin
  anHoverBtClose.Start;
end;

procedure TFrContasAReceber.ImgBtCloseApplicationMouseLeave(Sender: TObject);
begin
  anUnhoverBtClose.Start;
end;

procedure TFrContasAReceber.RbTipoPagamentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAReceber.RbTipoVencimentoChange(Sender: TObject);
begin
  ConsultarContas;
end;

procedure TFrContasAReceber.SpBtAdicionarParcelaClick(Sender: TObject);
begin
  Botoes.Salvar('P');
end;

procedure TFrContasAReceber.SpBtCancelarClick(Sender: TObject);
begin
  Botoes.Cancelar;
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

{$ENDREGION}

{$REGION 'Comandos a serem executados nas a��es de CRUD'}

procedure navBar.Adicionar;
begin
  with FrContasAReceber do
    begin
      Permite_Alteracao           := False;
      Lanca_Parcela               := True;

      SpBtDeletar.Enabled         := False;
      SpBtEditar.Enabled          := False;
      SpBtNovo.Enabled            := False;
      SpBtCancelar.Enabled        := True;

      RctWorkSpace.Enabled        := True;
      GpParcelasReceber.Enabled   := True;
      NovoOuEdita:= 'N';

      TbWork.TabIndex             := 0;
      Limparcampos;
    end;
end;

procedure navBar.Cancelar;
begin
  with FrContasAReceber do
    begin
      NovoOuEdita:= '';
      Permite_Alteracao                   := True;
      Lanca_Parcela                       := False;

      SpBtDeletar.Enabled                 := True;
      SpBtEditar.Enabled                  := True;
      SpBtNovo.Enabled                    := True;
      SpBtCancelar.Enabled                := False;

      RctWorkSpace.Enabled                := False;
      GpParcelasReceber.Enabled           := False;

      TbWork.TabIndex                     := 1;
      ConsultarContas;
      Limparcampos;
    end;
end;

procedure navBar.Editar;
var
   chave: Integer;
begin
  with FrContasAReceber do
    begin
      NovoOuEdita:= 'E';
      Permite_Alteracao                   := False;
      Lanca_Parcela                       := True;

      SpBtDeletar.Enabled                 := False;
      SpBtEditar.Enabled                  := False;
      SpBtNovo.Enabled                    := False;
      SpBtCancelar.Enabled                := True;

      RctWorkSpace.Enabled                := True;
      GpParcelasReceber.Enabled           := True;

      chave := itemConsultaPagar;

      CbTiposDeContas.ItemIndex:= -1;
      EdtValorDaConta.Text:= FormatFloat('###,###,##0.00', BaseResultadoConta[chave].Valor);
      DePagamento.Date:= BaseResultadoConta[chave].Recebimento;
      DeVencimento.Date:= BaseResultadoConta[chave].Vencimento;
      EdtNomeConta.Text:= BaseResultadoConta[chave].CodigoConta;
      chaveRegistroEdicao:= BaseResultadoConta[chave].IdTabela;
      LstBxParcelasAPagar.Clear;

      TbWork.TabIndex                     := 0;
    end;
end;

procedure navBar.Excluir;
begin
  with FrContasAReceber do
    begin

    if Permite_Alteracao = True then
      begin

      if A.mensagemAlerta('', 'Confirma Exclus�o?', 1) = True then
        begin
          LstBxConsulta.Clear;
          Base.DeletaConta(BaseResultadoConta[itemConsultaPagar].IdTabela);
          Cancelar;
        end
      else
        begin
          A.mensagemAlerta('', 'Opera��o Cancelada', 0);
        end;
      end
    else
      begin
        Cancelar;
        E.mensagemErro('Imposs�vel concluir opera��o',
                       'N�o � poss�vel chamar a opera��o de exclus�o no momento. Sua opera��o atual foi cancelada', 0);
      end;
    end;
end;

procedure navBar.Pesquisar;
begin
  with FrContasAReceber do
    begin

    if Permite_Alteracao = False then
      begin

      if A.mensagemAlerta('', 'Certeza? Sua opera��o atual ser� cancelada', 1) = True then
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
  with FrContasAReceber do
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
              E.mensagemErro('VALOR INV�LIDO', 'VOC� N�O PODE GERAR UMA PARCELA SEM VALOR!!', 0);

              EdtValorParcela.SetFocus;
            end
          else
            begin
              E.mensagemErro('SEM CONTA', 'VOC� N�O PODE GERAR UMA PARCELA SEM UMA CONTA!!!', 0);
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

          Lanca_Parcela                := False;
          Permite_Alteracao            :=  True;
          LstBxConsulta.Clear;

          SpBtDeletar.Enabled          := True;
          SpBtEditar.Enabled           := True;
          SpBtNovo.Enabled             := true;
          SpBtCancelar.Enabled         := False;

          RctWorkSpace.Enabled         := False;
          GpParcelasReceber.Enabled    := False;

          Cancelar;
          TbWork.TabIndex              := 1;
          Limparcampos;
        end
      else
        begin
          A.mensagemAlerta('', 'Opera��o Cancelada', 0);
        end;
      end;
    end;
end;
{$ENDREGION}

end.
