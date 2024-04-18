unit UnDBcontasAPagar;

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
  FMX.StdCtrls,

   DmMaster;
    {$ENDREGION}

type
   TRegistro = class
     private
        TId: Integer;
        TIdTabela: integer;
        TCodigoConta: string;
        TValor: Double;
        TPagamento: TDate;
        TVencimento: TDAte;
        TDespesa: Integer;
        TObservacoes: string;
        TCReated: TDateTime;
        TUpdated: TDateTime;
     public
        property Id                          : Integer      read TId           write TId;
        property IdTabela                    : Integer      read TIdTabela     write TIdTabela;
        property CodigoConta                 : string       read TCodigoConta  write TCodigoConta;
        property Valor                       : Double       read TValor        write TValor;
        property Pagamento                   : TDate        read TPagamento    write TPagamento;
        property Vencimento                  : TDate        read TVencimento   write TVencimento;
        property Despesa                     : Integer      read TDespesa      write TDespesa;
        property Observacoes                 : string       read TObservacoes  write TObservacoes;
        property Created                     : TDateTime    read TCReated      write TCReated;
        property Updated                     : TDateTime    read TUpdated      write TUpdated;
   end;


    DBPagar = class

      //Salvamento
      procedure SalvaConta(conta: string; valor: Double; Pagamento, Vencimento: TDate; Despesa: Integer; Obs: string);
      procedure SalvaParcela(IdConta: integer; valor: Double; Pagamento: TDate; Obs: string);

      //Exclusão
      procedure DeletaConta(idConta: integer);
      procedure DeletaParcela(IdParcela: integer);

      //Consulta
      function PesquisarContas(TipoData: Integer; Inicio, Fim: TDate): TList<TRegistro>;
      function PesquisarParcelas(IdConta: integer): TList<TRegistro>;

      //Visualização
      function DadosDaConta(IdConta: integer): TList<TRegistro>;
      function DadosDaPArcela(IdConta: integer): TList<TRegistro>;

    end;

  var
     nomeConta, Observacoes: string;
     Cons: Query;
     i: Integer;
     BaseResultadoConta: TList<TRegistro>;

implementation

uses
   UnContasAPagar;

procedure salvaDadosConta(tbId: Integer; tbConta: string; tbValor: Double; tbPagamento, tbVencimento: TDate; tbDespesa: Integer; tbObservacoes: string; tbCreated, tbUpdated: TDateTime);
begin

  BaseResultadoConta.Add(TRegistro.Create);

  with BaseResultadoConta[i] do
    begin
      id                  := i;
      IdTabela            := tbId;
      CodigoConta         := tbConta;
      Valor               := tbValor;
      Pagamento           := tbPagamento;
      Vencimento          := tbVencimento;
      Despesa             := tbDespesa;
      Observacoes         := tbObservacoes;
      Created             := tbCreated;
      Updated             := tbUpdated;
    end;

    i:= i + 1;
end;

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
  Fim: TDate): TList<TRegistro>;
var
   Campo_Data: string;
begin

  i:= 0;

  if TipoData = 0 then
    Campo_Data:= 'DATA_VENCIMENTO'
  else
    Campo_Data:= 'DATA_PAGAMENTO';

  with Cons.FB do
    begin
      setQuery(1);
      select('CT_PAGAR','','',Campo_Data + ' BETWEEN :INICIO AND :FIM ', Campo_Data);
      parameters([Inicio, Fim], ['INICIO', 'FIM']);

    while QryFb.Eof = False do
      begin
        salvaDadosConta(vlrField('ID'), vlrField('CODIGO_CONTA'), vlrField('VALOR_PAGAMENTO'), vlrField('DATA_PAGAMENTO'), vlrField('DATA_VENCIMENTO'), vlrField('DESPESA'), vlrField('OBSERVACOES'), vlrField('CREATED_AT'), vlrField('UPDATED_AT'));
        QryFb.Next;
      end;
    end;

  Result:= BaseResultadoConta;
end;

function DBPagar.PesquisarParcelas(IdConta: integer): TList<TRegistro>;
begin
  //pass
end;
// -----------------------------------------------------------------------------


// Visualização ----------------------------------------------------------------
function DBPagar.DadosDaConta(IdConta: integer): TList<TRegistro>;
begin
  //pass
end;

function DBPagar.DadosDaPArcela(IdConta: integer): TList<TRegistro>;
begin
  //pass
end;
// -----------------------------------------------------------------------------


end.
