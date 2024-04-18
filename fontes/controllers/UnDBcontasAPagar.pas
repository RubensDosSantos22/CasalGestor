unit UnDBcontasAPagar;

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

type
    TDados                       = array [0..5] of Variant;
    TDadosParcela                = array [0..3] of Variant;
    TResultadoConsulta           = array of Variant;
    TResultadoConsultaParcela    = array of Variant;

    DBPagar = class

      //Salvamento
      procedure SalvaConta(conta: string; valor: Double; Pagamento, Vencimento: TDate; Despesa: Integer; Obs: string);
      procedure SalvaParcela(IdConta: integer; valor: Double; Pagamento: TDate; Obs: string);

      //Exclusão
      procedure DeletaConta(idConta: integer);
      procedure DeletaParcela(IdParcela: integer);

      //Consulta
      function PesquisarContas(TipoData: Integer; Inicio, Fim: TDate): TResultadoConsulta;
      function PesquisarParcelas(IdConta: integer): TResultadoConsultaParcela;

      //Visualização
      function DadosDaConta(IdConta: integer): TDados;
      function DadosDaPArcela(IdConta: integer): TDadosParcela;
    end;

  var
     nomeConta, Observacoes: string;
     Cons: Query;

implementation

uses
   UnContasAPagar;

{ DBPagar }

// Salvamento ------------------------------------------------------------------

procedure DBPagar.SalvaConta(conta: string; valor: Double; Pagamento,
  Vencimento: TDate; Despesa: Integer; Obs: string);
begin
  //pass
end;

procedure DBPagar.SalvaParcela(IdConta: integer; valor: Double;
  Pagamento: TDate; Obs: string);
begin
  //pass
end;

// -----------------------------------------------------------------------------

// Exclusão --------------------------------------------------------------------

procedure DBPagar.DeletaConta(idConta: integer);
begin
  //pass
end;

procedure DBPagar.DeletaParcela(IdParcela: integer);
begin
  //pass
end;

// -----------------------------------------------------------------------------

// Consulta --------------------------------------------------------------------
function DBPagar.PesquisarContas(TipoData: Integer; Inicio,
  Fim: TDate): TResultadoConsulta;
var
   Campo_Data: string;
begin
  if TipoData = 0 then
    Campo_Data:= 'DATA_VENCIMENTO'
  else
    Campo_Data:= 'DATA_PAGAMENTO';

  Cons.FB.setQuery(1);
  Cons.FB.select('CT_PAGAR','','',Campo_Data + ' BETWEEN ' + DateToStr(Inicio) + ' AND ' + DateToStr(Fim), Campo_Data);
end;

function DBPagar.PesquisarParcelas(IdConta: integer): TResultadoConsultaParcela;
begin
  //pass
end;
// -----------------------------------------------------------------------------


// Visualização ----------------------------------------------------------------
function DBPagar.DadosDaConta(IdConta: integer): TDados;
begin
  //pass
end;

function DBPagar.DadosDaPArcela(IdConta: integer): TDadosParcela;
begin
  //pass
end;
// -----------------------------------------------------------------------------


end.
