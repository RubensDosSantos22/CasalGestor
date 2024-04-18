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

  LibDesign;

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
    LvResultadoPesquisa: TListView;
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

    {$ENDREGION}

    {$REGION 'Declara��o das procedures e vari�veis da tela'}

    procedure EdtValorDaContaEnter(Sender: TObject);
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
  private
    Anim1: animNoTime;
    Parcela: ItemGrids;
    Botoes: Navbar;
  public
    Lanca_Parcela, Permite_Alteracao: Boolean;
    Valor: string;

    {$ENDREGION}

  end;

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

{$ENDREGION}

{$R *.fmx}

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

{$REGION 'A��es dos Edits'}

procedure TFrContasAReceber.EdtValorDaContaEnter(Sender: TObject);
begin
  if (StrToFloat(EdtValorDaConta.Text) = 0) then
     EdtValorDaConta.Text:= '';
end;

procedure TFrContasAReceber.EdtValorDaContaKeyDown(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorDaConta.Text:= onlyNumber(EdtValorDaConta.Text);
end;

procedure TFrContasAReceber.EdtValorDaContaKeyUp(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorDaConta.Text:= onlyNumber(EdtValorDaConta.Text);
end;


procedure TFrContasAReceber.EdtValorParcelaEnter(Sender: TObject);
begin
  if (StrToFloat(EdtValorParcela.Text) = 0) then
    EdtValorParcela.Text:= '';
end;

procedure TFrContasAReceber.EdtValorParcelaKeyDown(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorParcela.Text:= onlyNumber(EdtValorParcela.Text);
end;

procedure TFrContasAReceber.EdtValorParcelaKeyUp(Sender: TObject; var Key:
    Word; var KeyChar: Char; Shift: TShiftState);
begin
  EdtValorParcela.Text:= onlyNumber(EdtValorParcela.Text);
end;

{$ENDREGION}

{$REGION 'A��es do Formul�rio'}

procedure TFrContasAReceber.FormShow(Sender: TObject);
begin
  RctWorkSpace.Enabled                     := False;
  GpParcelasReceber.Enabled                := False;
  Permite_Alteracao                        := True;
  TbWork.TabIndex                          := 1;
end;

procedure TFrContasAReceber.FormClose(Sender: TObject; var Action:
    TCloseAction);
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

procedure TFrContasAReceber.SpBtCancelarClick(Sender: TObject);
begin
  Botoes.Cancelar;
end;

procedure TFrContasAReceber.SpBtAdicionarParcelaClick(Sender: TObject);
begin
  Botoes.Salvar('P');
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

      TbWork.TabIndex             := 0;
      Limparcampos;
    end;
end;

procedure navBar.Cancelar;
begin
  with FrContasAReceber do
    begin
      Permite_Alteracao                   := True;
      Lanca_Parcela                       := False;

      SpBtDeletar.Enabled                 := True;
      SpBtEditar.Enabled                  := True;
      SpBtNovo.Enabled                    := True;
      SpBtCancelar.Enabled                := False;

      RctWorkSpace.Enabled                := False;
      GpParcelasReceber.Enabled           := False;

      TbWork.TabIndex                     := 1;
      Limparcampos;
    end;
end;

procedure navBar.Editar;
begin
  with FrContasAReceber do
    begin
      Permite_Alteracao                   := False;
      Lanca_Parcela                       := True;

      SpBtDeletar.Enabled                 := False;
      SpBtEditar.Enabled                  := False;
      SpBtNovo.Enabled                    := False;
      SpBtCancelar.Enabled                := True;

      RctWorkSpace.Enabled                := True;
      GpParcelasReceber.Enabled           := True;

      TbWork.TabIndex                     := 0;
    end;
end;

procedure navBar.Excluir;
begin
  with FrContasAReceber do
    begin

    if Permite_Alteracao = True then
      begin

      if messagedlg('Confirma Exclus�o?' ,mtConfirmation,[mbYes,MbNo],0) = mrYes then
        begin
          Cancelar;
        end
      else
        begin
          ShowMessage('Opera��o Cancelada');
        end;
      end
    else
      begin
        Cancelar;
        ShowMessage('N�o � poss�vel chamar a opera��o de exclus�o no momento. Sua opera��o atual foi cancelada');
      end;
    end;
end;

procedure navBar.Pesquisar;
begin
  with FrContasAReceber do
    begin

    if Permite_Alteracao = False then
      begin

      if messagedlg('Certeza? Sua opera��o atual ser� cancelada' ,mtConfirmation,[mbYes,MbNo],0) = mrYes then
        begin
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
              FrmErroSistema:= TFrmErroSistema.Create(Application);
              FrmErroSistema.LblTituloErro.Text:= 'VALOR INV�LIDO';
              FrmErroSistema.LblDescricaoErro.Text:= 'VOC� N�O PODE GERAR UMA PARCELA SEM VALOR!!';
              FrmErroSistema.RctTituloErro.Fill.Color:= RctDadosParcela.Fill.Color;
              FrmErroSistema.SpBtAcao2.Visible:= False;
              FrmErroSistema.ImgErro.Visible:= True;
              FrmErroSistema.ImgAviso.Visible:= False;
              FrmErroSistema.ShowModal;
              EdtValorParcela.SetFocus;
            end
          else
            begin
              FrmErroSistema:= TFrmErroSistema.Create(Application);
              FrmErroSistema.LblTituloErro.Text:= 'SEM CONTA';
              FrmErroSistema.LblDescricaoErro.Text:= 'VOC� N�O PODE GERAR UMA PARCELA SEM UMA CONTA!!!';
              FrmErroSistema.RctTituloErro.Fill.Color:= RctDadosParcela.Fill.Color;
              FrmErroSistema.SpBtAcao2.Visible:= False;
              FrmErroSistema.ImgErro.Visible:= True;
              FrmErroSistema.ImgAviso.Visible:= False;
              FrmErroSistema.ShowModal;
              EdtNomeConta.SetFocus;
            end;
          end;
        end;
      end
    else if Permite_Alteracao = False then
      begin

      if messagedlg('Confirma Salvamento?' ,mtConfirmation,[mbYes,MbNo],0) = mrYes then
        begin
          Lanca_Parcela                := False;
          Permite_Alteracao            :=  True;

          SpBtDeletar.Enabled          := True;
          SpBtEditar.Enabled           := True;
          SpBtNovo.Enabled             := true;
          SpBtCancelar.Enabled         := False;

          RctWorkSpace.Enabled         := False;
          GpParcelasReceber.Enabled    := False;

          TbWork.TabIndex              := 1;
          Limparcampos;
        end
      else
        begin
          ShowMessage('Opera��o Cancelada');
        end;
      end;
    end;
end;
{$ENDREGION}

end.
