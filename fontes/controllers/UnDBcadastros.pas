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
   dataConvert = class
     function dataParaString(Dt: TDate): string;
   end;

    Despesas = class
      procedure despesaCombobox(Cbx: TCombobox);
      procedure consultaDespesa;
    end;


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
begin
  //pass
end;

end.
