unit LibDesign;

interface

/// <summary>
///  Esta unit contém a implementação das classes de design do projeto, de forma global
/// </summary>
/// <remarks>
///  A classe animNoTime realiza o trabalho gráfico dos menus das telas.
/// </remarks>

uses
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
  UnFrmItensContas;

  type
    animNoTime = class
      /// <summary>
      ///  Abre e fecha o menu da tela inicial do sistema. APENAS USADO NA TELA INDEX
      /// </summary>
      procedure abreMenu;
      /// <summary>
      ///  Abre e fecha o menu das demais telas do sistema.
      /// </summary>
      procedure abreAuxiliar;
    end;

    btAnim = class
      procedure state;
    end;

    ItemGrids = class
      procedure addParcela(lb: TListbox; conta, data, valor : string);
  private
    procedure deleteItem(Sender: TObject);
    end;

  var
    ActualScreen: Tform;
    FrAnexo: TFrmItensContas;


implementation

{ animNoTime }

procedure animNoTime.abreAuxiliar;
var
  Menu:  TRectangle;
  aMenu: TfloatAnimation;
  fMenu: TfloatAnimation;
begin

end;

procedure animNoTime.abreMenu;
begin

end;

{ btAnim }

procedure btAnim.state;
begin
  //pass
end;

{ imgTiposDeArquivo }

procedure ItemGrids.addParcela(lb: TListbox; conta, data, valor : string);
var
  item: TlistboxItem;
  Img: ItemGrids;

  Nome, Tamanho, UpdatedAt: string;
begin

  item:= TListBoxItem.Create(nil);
  item.Text:= '';
  item.Height:= 65;
  item.TagString:= DateTimeToStr(now);

  FrAnexo:= TFrmItensContas.Create(item);
  FrAnexo.Parent:= item;
  FrAnexo.Align:= TAlignLayout.Client;

  FrAnexo.LblConta.Text         := conta;
  FrAnexo.LblPagamento.Text     := data;
  FrAnexo.LblValor.Text         := 'R$' + valor;
  FrAnexo.LblVencimento.Visible := False;

  FrAnexo.SpBtDeleteItem.OnClick:= deleteItem;
  lb.AddObject(item);

end;

procedure ItemGrids.deleteItem(Sender: TObject);
var
  Anexo: TFrmItensContas;
  Item: TListBoxItem;
  btn: TSpeedButton;
begin

  btn:= Sender as TSpeedbutton;
  Anexo:= btn.Parent as TFrmItensContas;
  Item:= Anexo.Parent as TListBoxItem;
  Item.Destroy;
end;

end.
