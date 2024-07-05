unit LibControlGrids;
interface
/// <summary>
///          Esta unit contém a implementação das classes de design do projeto, de forma global
/// </summary>
/// <remarks>
///          A classe animNoTime realiza o trabalho gráfico dos menus das telas.
/// </remarks>
uses
  {$REGION 'Declaração das Uses da Biblioteca'}
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
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
  FMX.WebBrowser,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.Layouts,
  FMX.ImgList,
  FMX.Menus,
  FMX.ActnList,
  FMX.Printer,
  FMX.ListBox,
  FMX.Effects,
  FMX.Colors,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.DateTimeCtrls,
  FMX.ListView,

  Vcl.Dialogs,
  UnFrmItensContas,
  UnDBcontasAPagar;
  {$ENDREGION}
type
  TFatores = class
     private

        TValorAtual1     : Double;
        TValorAtual2     : Double;

     public

        property ValorAtual1                       : Double       read TValorAtual1        write TValorAtual1;
        property ValorAtual2                       : Double       read TValorAtual2        write TValorAtual2;

   end;
  TItemGrids = class
    /// <summary>
    ///          Função responsável por adicinar contas no modelo de grid
    /// </summary>
    procedure addConta(lb: TListbox; conta: string; valor: Double; pagamento, vencimento, idTabela: string; id: integer);

    procedure addParcela(lb: TListbox; conta, valor, pagamento, vencimento, idTabela: string; id: integer);
    procedure resetSearch;
  private
    procedure deleteConta(Sender: TObject);
    procedure selectedConta(Sender: TObject);
    procedure editConta(Sender: TObject);

    procedure deleteParcela(Sender: TObject);
    procedure selectedParcela(Sender: TObject);
    procedure editParcela(Sender: TObject);
  end;
  var
    FrmContas: TFrmItensContas;
    FrmParcelas: TFrmItensContas;
    item: TlistboxItem;
    Base: DBPagar;
    itemConsultaPagar: Integer;
    Anexo, anexoAnterior: TFrmItensContas;
    stp: string;
    FatoresPagar   : TFatores;
    FatoresParcelas: TFatores;
    FatoresReceber : TFatores;

implementation


procedure TItemGrids.addConta(lb: TListbox; conta: string; valor: Double; pagamento, vencimento, idTabela: string; id: integer);
begin
  item:= TListBoxItem.Create(nil);
  item.Text:= '';
  item.Height:= 65;
  item.TagString:= IntToStr(id);

  FrmContas:= TFrmItensContas.Create(item);
  with FrmContas do
    begin
      Parent:= item;
      Align:= TAlignLayout.Client;
      LblConta.Text         := 'Conta: ' + conta;
      LblPagamento.Text     := 'Pagamento: ' + pagamento;
      LblValor.Text         := FormatFloat('###,###,##0.00', valor);
      LblVencimento.Text    := 'Vencimento: ' + vencimento;
      LblIdTabela.Text      := idTabela;
      SpBtDeleteItem.OnClick:= deleteConta;
      OnClick:= selectedConta;
      OnDblClick:= editConta;
    end;

  lb.AddObject(item);

  if Pagamento = '01/01/2000' then
    begin
      FatoresPagar.ValorAtual1:= FatoresPagar.ValorAtual1 + valor;
    end
  else
    begin
      FatoresPagar.ValorAtual2:= FatoresPagar.ValorAtual2 + valor;
    end;
end;

procedure TItemGrids.deleteConta(Sender: TObject);
var
  btn: TSpeedButton;
begin
  btn:= Sender as TSpeedbutton;
  Anexo:= btn.Parent as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  Base.DeletaConta(StrToInt(Anexo.LblIdTabela.Text));

  if Anexo.LblPagamento.Text = 'Pagamento: 01/01/2000' then
    begin
      FatoresPagar.ValorAtual1:= FatoresPagar.ValorAtual1 - StrToFloat(Anexo.LblValor.Text);
    end
  else
    begin
      FatoresPagar.ValorAtual2:= FatoresPagar.ValorAtual2 - StrToFloat(Anexo.LblValor.Text);
    end;

  anexoAnterior:= nil;
  Item.Destroy;
end;
procedure TItemGrids.editConta(Sender: TObject);
begin
  Anexo:= Sender as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  itemConsultaPagar   := StrToInt(Item.TagString);
end;

procedure TItemGrids.resetSearch;
begin
  Anexo:= nil;
  anexoAnterior:= nil;
end;
procedure TItemGrids.selectedConta(Sender: TObject);
begin
  if anexoAnterior <> nil then
    begin
      anexoAnterior.LblConta.FontColor             := TAlphaColorRec.Black;
      anexoAnterior.LblPagamento.FontColor         := anexoAnterior.LblConta.FontColor;
      anexoAnterior.LblVencimento.FontColor        := anexoAnterior.LblConta.FontColor;
      anexoAnterior.LblValor.FontColor             := anexoAnterior.LblConta.FontColor;
      anexoAnterior:= nil;
    end;
  Anexo               := Sender as TFrmItensContas;
  Item                := Anexo.Parent as TListBoxItem;
  itemConsultaPagar   := StrToInt(Item.TagString);

  Anexo.LblConta.FontColor                                := TAlphaColorRec.Red;
  Anexo.LblPagamento.FontColor                            := Anexo.LblConta.FontColor;
  Anexo.LblVencimento.FontColor                           := Anexo.LblConta.FontColor;
  Anexo.LblValor.FontColor                                := Anexo.LblConta.FontColor;
  anexoAnterior                                           := Anexo;
end;


procedure TItemGrids.addParcela(lb: TListbox; conta, valor, pagamento, vencimento, idTabela: string; id: integer);
begin
  item:= TListBoxItem.Create(nil);
  item.Text:= '';
  item.Height:= 65;
  item.TagString:= IntToStr(id);

  FrmParcelas:= TFrmItensContas.Create(item);

  with FrmParcelas do
    begin
      Parent:= item;
      Align:= TAlignLayout.Client;
      LblConta.Text         := 'Conta: ' + conta;
      LblPagamento.Text     := pagamento;
      LblValor.Text         := valor;
      LblVencimento.Text    := vencimento;
      LblIdTabela.Text      := idTabela;
      SpBtDeleteItem.OnClick:= deleteParcela;
      OnClick:= selectedParcela;
      OnDblClick:= editParcela;
    end;

  lb.AddObject(item);

  if Pagamento = '01/01/2000' then
    begin
      FatoresParcelas.ValorAtual1:= FatoresParcelas.ValorAtual1 + StrToFloat(valor);
    end
  else
    begin
      FatoresParcelas.ValorAtual2:= FatoresParcelas.ValorAtual2 + StrToFloat(valor);
    end;
end;

procedure TItemGrids.deleteParcela(Sender: TObject);
var
  btn: TSpeedButton;
begin
  btn:= Sender as TSpeedbutton;
  Anexo:= btn.Parent as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  Base.DeletaParcela(StrToInt(Anexo.LblIdTabela.Text));

  if Anexo.LblPagamento.Text = '01/01/2000' then
    begin
      FatoresParcelas.ValorAtual1:= FatoresParcelas.ValorAtual1 - StrToFloat(Anexo.LblValor.Text);
    end
  else
    begin
      FatoresParcelas.ValorAtual2:= FatoresParcelas.ValorAtual2 - StrToFloat(Anexo.LblValor.Text);
    end;

  Item.Destroy;
end;

procedure TItemGrids.selectedParcela(Sender: TObject);
begin

  if anexoAnterior <> nil then
    begin
      anexoAnterior.LblConta.FontColor             := TAlphaColorRec.Black;
      anexoAnterior.LblPagamento.FontColor         := anexoAnterior.LblConta.FontColor;
      anexoAnterior.LblVencimento.FontColor        := anexoAnterior.LblConta.FontColor;
      anexoAnterior.LblValor.FontColor             := anexoAnterior.LblConta.FontColor;
      anexoAnterior:= nil;
    end;
  Anexo               := Sender as TFrmItensContas;
  Item                := Anexo.Parent as TListBoxItem;
  itemConsultaPagar   := StrToInt(Anexo.LblIdTabela.Text);
  Anexo.LblConta.FontColor                                := TAlphaColorRec.Red;
  Anexo.LblPagamento.FontColor                            := Anexo.LblConta.FontColor;
  Anexo.LblVencimento.FontColor                           := Anexo.LblConta.FontColor;
  Anexo.LblValor.FontColor                                := Anexo.LblConta.FontColor;
  anexoAnterior                                           := Anexo;
end;
procedure TItemGrids.editParcela(Sender: TObject);
begin
  Anexo:= Sender as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  itemConsultaPagar:= StrToInt(Item.TagString);
end;
end.
