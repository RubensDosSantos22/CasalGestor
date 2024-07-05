unit UnDBcadastros;

interface

uses
    {$REGION 'Uses do Projeto'}

  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.IOUtils,
  System.Rtti,
  System.Net.HttpClient {Androidapi.Helpers},
  System.Generics.Collections,
  System.Types,
  System.UITypes,
  System.Variants,

  Data.DB,
  MemDS,
  DBAccess,
  Uni,
  UniProvider,
  InterBaseUniProvider,

  MySQLUniProvider,

  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,

  IBX.IBSQL,
  IBX.IBDatabase,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Phys.FBDef,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.DatS,
  FireDAC.Phys.FB,

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

   DmMaster;
    {$ENDREGION}

type
  comboItemDespesa = class(TListBoxItem)
  private
    Tid                : integer;
    TDisplay           : string;
    TCdDespesa         : string;
  public
    property id        : integer read Tid write Tid;
    property Display   : string read TDisplay write TDisplay;
    property CdDespesa : string read TCdDespesa write TCdDespesa;
  end;

  comboItemReceita = class(TListBoxItem)
  private
    Tid                : integer;
    TDisplay           : string;
    TCdReceita         : string;
  public
    property id        : integer read Tid write Tid;
    property Display   : string read TDisplay write TDisplay;
    property CdReceita : string read TCdReceita write TCdReceita;
  end;

  dataConvert = class
   function dataParaString(Dt: TDate): string;
  end;

  Despesas = class
    procedure despesaCombobox(Cbx: TCombobox);
    procedure despToCbxItem(Cbx: TCombobox; id: integer);
    procedure consultaDespesa;
  end;

  Receitas = class
    procedure receitaCombobox(Cbx: TCombobox);
    procedure receToCbxItem(Cbx: TCombobox; id: integer);
    procedure consultaReceita;
  end;

  TComboItemInfo = record
    Index: Integer;
    ID: Integer;
  end;

var
  iDCbx: comboItemDespesa;
  iRCbx: comboItemReceita;
  ItemInfo: TComboItemInfo;
  Cons: Query;
  ComboItemsMap: TDictionary<Integer, TComboItemInfo>;

implementation

{ dataConvert }

function dataConvert.dataParaString(Dt: TDate): string;
begin
  //pass
end;

{ Despesas }

procedure Despesas.consultaDespesa;
begin
  //pass
end;

procedure Despesas.despesaCombobox(Cbx: TCombobox);
var
  i: Integer;
begin

  if ComboItemsMap <> nil then
     ComboItemsMap.Clear;

  with Cons.FB do
    begin
      setQuery(3);
      select('TP_DESPESA','','','', 'NOME');

      ComboItemsMap:= TDictionary<Integer, TComboItemInfo>.Create;

      Cbx.Controls.Clear;
      Cbx.BeginUpdate;

    while not QryFb.Eof do
      begin
        iDCbx := comboItemDespesa.Create(Cbx);

      with iDCbx as comboItemDespesa do
        begin
          Parent        := Cbx;
          Name          := 'item' + VarToStr(vlrField('ID'));
          ItemData.Text := vlrField('NOME');
          id            := vlrField('ID');
          Display       := vlrField('NOME');
          CdDespesa     := vlrField('CODIGO_DESPESA');
          Tag           := vlrField('ID');

        ItemInfo.Index := Cbx.ControlsCount;
        ItemInfo.ID := iDCbx.id;

        ComboItemsMap.Add(iDCbx.id, ItemInfo);

        TThread.Synchronize(TThread.CurrentThread,
          procedure()
          begin
            Cbx.Controls.Add(iDCbx);
          end);
        end;
        QryFb.Next;
      end;

      Cbx.EndUpdate;
    end;
end;


procedure Despesas.despToCbxItem(Cbx: TCombobox; id: integer);
begin

  if ComboItemsMap.TryGetValue(id, ItemInfo) then
    Cbx.ItemIndex := ItemInfo.Index
  else
    ShowMessage('Despesa não encontrada');
end;

{ Receitas }

procedure Receitas.consultaReceita;
begin
  //pass
end;

procedure Receitas.receitaCombobox(Cbx: TCombobox);
var
  i: Integer;
begin

  if ComboItemsMap <> nil then
     ComboItemsMap.Clear;

  with Cons.FB do
    begin
      setQuery(3);
      select('TP_RECEITA','','','', 'NOME');

      ComboItemsMap:= TDictionary<Integer, TComboItemInfo>.Create;

      Cbx.Controls.Clear;
      Cbx.BeginUpdate;

    while not QryFb.Eof do
      begin
        iRCbx := comboItemReceita.Create(Cbx);

      with iRCbx as comboItemReceita do
        begin
          Parent        := Cbx;
          Name          := 'item' + VarToStr(vlrField('ID'));
          ItemData.Text := vlrField('NOME');
          id            := vlrField('ID');
          Display       := vlrField('NOME');
          CdReceita     := vlrField('CODIGO_RECEITA');
          Tag           := vlrField('ID');

        ItemInfo.Index  := Cbx.ControlsCount;
        ItemInfo.ID     := iRCbx.id;

        ComboItemsMap.Add(iRCbx.id, ItemInfo);

        TThread.Synchronize(TThread.CurrentThread,
          procedure()
          begin
            Cbx.Controls.Add(iRCbx);
          end);
        end;
        QryFb.Next;
      end;

      Cbx.EndUpdate;
    end;
end;


procedure Receitas.receToCbxItem(Cbx: TCombobox; id: integer);
begin

  if ComboItemsMap.TryGetValue(id, ItemInfo) then
    Cbx.ItemIndex := ItemInfo.Index
  else
    ShowMessage('Despesa não encontrada');
end;

end.
