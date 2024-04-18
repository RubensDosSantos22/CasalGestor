unit UnDBcontasAReceber;

interface

uses

    {$REGION 'Uses do Projeto'}
  System.SysUtils, System.Classes, System.DateUtils, System.IOUtils, System.Rtti,

  Data.DB, MemDS, DBAccess, Uni, UniProvider, InterBaseUniProvider,

  MySQLUniProvider,

  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,

  IBX.IBSQL,                       IBX.IBDatabase,

  FireDAC.Stan.Intf,               FireDAC.Stan.Option,
  FireDAC.Stan.Error,              FireDAC.UI.Intf,
  FireDAC.Stan.Pool,               FireDAC.Stan.Async,
  FireDAC.Phys.SQLiteDef,          FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client,             FireDAC.Stan.Param,
  FireDAC.DApt.Intf,               FireDAC.DApt,
  FireDAC.Phys.FBDef,              FireDAC.Comp.DataSet,
  FireDAC.Phys.Intf,               FireDAC.Stan.Def,
  FireDAC.Phys,                    FireDAC.Phys.SQLite,
  FireDAC.DatS,                    FireDAC.Phys.FB,

  System.Net.HttpClient {Androidapi.Helpers},
  DmMaster;
    {$ENDREGION}

implementation

uses
    UnContasAReceber;

end.
