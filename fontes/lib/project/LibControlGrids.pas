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

  ItemGrids = class

    procedure addParcela(lb: TListbox; conta, data, valor : string);
    procedure addConta(lb: TListbox; conta, valor, vencimento, pagamento: string; id: integer);
    procedure resetSearch;
  private
    procedure deleteItem(Sender: TObject);
    procedure selectedItem(Sender: TObject);
    procedure editItem(Sender: TObject);
  end;

  var
    FrmParcela: TFrmItensContas;
    FrmConta: TFrmItensContas;
    item: TlistboxItem;
    Base: DBPagar;
    itemConsultaPagar: Integer;
    Anexo, anexoAnterior: TFrmItensContas;


implementation


procedure ItemGrids.addParcela(lb: TListbox; conta, data, valor : string);
begin

  item:= TListBoxItem.Create(nil);
  item.Text:= '';
  item.Height:= 65;
  item.TagString:= DateTimeToStr(now);

  FrmParcela:= TFrmItensContas.Create(item);
  FrmParcela.Parent:= item;
  FrmParcela.Align:= TAlignLayout.Client;

  FrmParcela.LblConta.Text         := conta;
  FrmParcela.LblPagamento.Text     := data;
  FrmParcela.LblValor.Text         := 'R$' + valor;
  FrmParcela.LblVencimento.Visible := False;

  FrmParcela.SpBtDeleteItem.OnClick:= deleteItem;
  lb.AddObject(item);

end;

procedure ItemGrids.addConta(lb: TListbox; conta, valor, vencimento, pagamento: string; id: integer);
begin

  item:= TListBoxItem.Create(nil);
  item.Text:= '';
  item.Height:= 65;
  item.TagString:= IntToStr(id);

  FrmParcela:= TFrmItensContas.Create(item);
  FrmParcela.Parent:= item;
  FrmParcela.Align:= TAlignLayout.Client;

  FrmParcela.LblConta.Text         := 'Conta: ' + conta;
  FrmParcela.LblPagamento.Text     := 'Pagamento: ' + pagamento;
  FrmParcela.LblValor.Text         := 'R$' + valor;
  FrmParcela.LblVencimento.Text    := 'Vencimento: ' + vencimento;

  FrmParcela.SpBtDeleteItem.OnClick:= deleteItem;
  FrmParcela.OnClick:= selectedItem;
  FrmParcela.OnDblClick:= editItem;
  lb.AddObject(item);

end;

procedure ItemGrids.deleteItem(Sender: TObject);
var
  btn: TSpeedButton;
begin

  btn:= Sender as TSpeedbutton;
  Anexo:= btn.Parent as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  Base.DeletaConta(StrToInt(Item.TagString));
  Item.Destroy;
end;

procedure ItemGrids.editItem(Sender: TObject);
begin
  Anexo:= Sender as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  itemConsultaPagar:= StrToInt(Item.TagString);
end;

procedure ItemGrids.resetSearch;
begin
  Anexo:= nil;
  anexoAnterior:= nil;
end;

procedure ItemGrids.selectedItem(Sender: TObject);
begin

  if anexoAnterior <> nil then
    begin
      anexoAnterior.LblConta.FontColor:= TAlphaColorRec.Black;
      anexoAnterior.LblPagamento.FontColor:= anexoAnterior.LblConta.FontColor;
      anexoAnterior.LblVencimento.FontColor:= anexoAnterior.LblConta.FontColor;
      anexoAnterior.LblValor.FontColor:= anexoAnterior.LblConta.FontColor;
      anexoAnterior:= nil;
    end;

  Anexo:= Sender as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  itemConsultaPagar:= StrToInt(Item.TagString);

  Anexo.LblConta.FontColor:= TAlphaColorRec.Red;
  Anexo.LblPagamento.FontColor:= Anexo.LblConta.FontColor;
  Anexo.LblVencimento.FontColor:= Anexo.LblConta.FontColor;
  Anexo.LblValor.FontColor:= Anexo.LblConta.FontColor;
  anexoAnterior:= Anexo;
end;

end.
