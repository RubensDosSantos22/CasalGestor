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

   DmMaster,
   UnDBcadastros;
    {$ENDREGION}

type
    {$REGION 'Declarações do controlador'}

   TConta = class
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

   TParcela = class
     private
        TId: Integer;
        TIdTabela: integer;
        TIdConta: integer;
        TValor: Double;
        TPagamento: TDate;
        TVencimento: TDate;
        TObservacoes: string;
     public
        property Id                          : Integer      read TId           write TId;
        property IdTabela                    : Integer      read TIdTabela     write TIdTabela;
        property Conta                       : Integer      read TIdConta      write TIdConta;
        property Valor                       : Double       read TValor        write TValor;
        property Pagamento                   : TDate        read TPagamento    write TPagamento;
        property vencimento                  : TDate        read Tvencimento   write Tvencimento;
        property Observacoes                 : string       read TObservacoes  write TObservacoes;
   end;

    DBPagar = class

      //Salvamento
      procedure SalvaConta(conta: string; valor: Double; Pagamento, Vencimento: TDate; Despesa: Integer; Obs: string; id: integer = 0);
      procedure SalvaParcela(IdConta: integer; valor: Double; Pagamento, Vencimento: TDate; Obs: string; id: integer = 0);

      //Exclusão
      procedure DeletaConta(idConta: integer);
      procedure DeletaParcela(IdParcela: integer);

      //Consulta
      function PesquisarContas(TipoData: string; Inicio, Fim: TDate): TList<TConta>;
      function PesquisarParcelas(IdConta: integer): TList<TParcela>;

      procedure PreencheContas(Cbx: TComboBox);

    private
      //Salvamento dos dados
      procedure salvaDadosConta(tbId: Integer; tbConta: string; tbValor: Double; tbPagamento, tbVencimento: TDate; tbDespesa: Integer; tbObservacoes: string; tbCreated, tbUpdated: TDateTime);
      procedure salvaDadosParcela(tbId, tbConta: integer; tbValor: Double; tbPagamento, tbVencimento: TDate; tbObservacoes: string);
    end;

  {$ENDREGION}

var
   BaseResultadoConta                     : TList<TConta>;
   BaseResultadoParcela                   : TList<TParcela>;
   Cons: Query;
   i: Integer;
   Desp: Despesas;

implementation

    {$REGION 'Procedimentos privados'}

procedure DBPagar.salvaDadosConta(tbId: Integer; tbConta: string; tbValor: Double; tbPagamento, tbVencimento: TDate; tbDespesa: Integer; tbObservacoes: string; tbCreated, tbUpdated: TDateTime);
begin

  BaseResultadoConta.Add(TConta.Create);

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

procedure DBPagar.salvaDadosParcela(tbId, tbConta: integer; tbValor: Double; tbPagamento, tbVencimento: TDate; tbObservacoes: string);
begin

  BaseResultadoParcela.Add(TParcela.Create);

  with BaseResultadoParcela[i] do
    begin
      id                  := i;
      IdTabela            := tbId;
      Conta               := tbConta;
      Valor               := tbValor;
      Pagamento           := tbPagamento;
      Vencimento          := tbVencimento;
      Observacoes         := tbObservacoes;
    end;

    i:= i + 1;
end;

{$ENDREGION}

    {$REGION 'Procedimentos Públicos'}

// Salvamento ------------------------------------------------------------------

procedure DBPagar.SalvaConta(conta: string; valor: Double; Pagamento,
  Vencimento: TDate; Despesa: Integer; Obs: string; id: integer = 0);
var
   pagto, vencto: string;
begin

  pagto:= DateToStr(Pagamento);
  pagto:= Copy(pagto, 4, 2) + '/' + Copy(pagto, 0, 2) + '/' + Copy(pagto, 7, 4);

  vencto:= DateToStr(Vencimento);
  vencto:= Copy(vencto, 4, 2) + '/' + Copy(vencto, 0, 2) + '/' + Copy(vencto, 7, 4);

  with Cons.FB do
    begin

      command_fields:= ['CODIGO_CONTA', 'VALOR_PAGAMENTO', 'DATA_PAGAMENTO', 'DATA_VENCIMENTO', 'DESPESA', 'OBSERVACOES'];

    if id = 0 then
      begin
        insert('CT_PAGAR', command_fields);
      end
    else
      begin
        update('CT_PAGAR', command_fields, id);
      end;

      parameters([conta, valor, pagto, vencto, Despesa, obs], command_fields);
    end;
end;

procedure DBPagar.SalvaParcela(IdConta: integer; valor: Double;
  Pagamento, Vencimento: TDate; Obs: string; id: integer = 0);
var
   pagto, vencto: string;
begin

  pagto:= DateToStr(Pagamento);
  pagto:= Copy(pagto, 4, 2) + '/' + Copy(pagto, 0, 2) + '/' + Copy(pagto, 7, 4);

  vencto:= DateToStr(Vencimento);
  vencto:= Copy(vencto, 4, 2) + '/' + Copy(vencto, 0, 2) + '/' + Copy(vencto, 7, 4);


  with Cons.FB do
    begin

      command_fields:= ['CONTA', 'VALOR', 'DATA_PAGAMENTO', 'DATA_VENCIMENTO', 'OBSERVACOES'];

    if id = 0 then
      begin
        insert('PARCELA_CT_PAGAR', command_fields);
      end
    else
      begin
        update('PARCELA_CT_PAGAR', command_fields, id);
      end;

      parameters([Idconta, valor, pagto, obs], command_fields);
    end;
end;

// -----------------------------------------------------------------------------

// Exclusão --------------------------------------------------------------------

procedure DBPagar.DeletaConta(idConta: integer);
begin
  Cons.FB.delete('CT_PAGAR', '', idConta);
end;

procedure DBPagar.DeletaParcela(idParcela: integer);
begin
  Cons.FB.delete('PARCELA_CT_PAGAR', '', idParcela);
end;

// -----------------------------------------------------------------------------

// Consulta --------------------------------------------------------------------
function DBPagar.PesquisarContas(TipoData: string; Inicio,
  Fim: TDate): TList<TConta>;
var
   Campo_Data: string;
   dtInicial, dtFinal: string;
begin

  if BaseResultadoConta <> nil then
    BaseResultadoConta.Destroy;

  i:= 0;

  if TipoData = '-1' then
    Campo_Data:= 'DATA_VENCIMENTO'
  else
    Campo_Data:= 'DATA_PAGAMENTO';

  BaseResultadoConta:= TList<TConta>.Create;

  with Cons.FB do
    begin
      dtInicial:= DateToStr(Inicio);
      dtInicial:= Copy(dtInicial, 4, 2) + '/' + Copy(dtInicial, 0, 2) + '/' + Copy(dtInicial, 7, 4);

      dtFinal:= DateToStr(Fim);
      dtFinal:= Copy(dtFinal, 4, 2) + '/' + Copy(dtFinal, 0, 2) + '/' + Copy(dtFinal, 7, 4);

      setQuery(1);
      select('CT_PAGAR','','',Campo_Data + ' BETWEEN :INICIO AND :FIM ', Campo_Data);
      parameters([dtInicial, dtFinal], ['INICIO', 'FIM']);

    if QryFb.Eof = False then
      begin

      while QryFb.Eof = False do
        begin
          salvaDadosConta(vlrField('ID'), vlrField('CODIGO_CONTA'), vlrField('VALOR_PAGAMENTO'), vlrField('DATA_PAGAMENTO'), vlrField('DATA_VENCIMENTO'), vlrField('DESPESA'), vlrField('OBSERVACOES'), vlrField('CREATED_AT'), vlrField('UPDATED_AT'));
          QryFb.Next;
        end;
      end
    else
      begin
        //ShowMessage('NÃO HÁ LANÇAMENTOS PARA O PERÍODO SELECIONADO');
      end;
    end;

  Result:= BaseResultadoConta;
end;

function DBPagar.PesquisarParcelas(IdConta: integer): TList<TParcela>;
begin
  i:= 0;

  BaseResultadoParcela:= TList<TParcela>.Create;

  with Cons.FB do
    begin

      setQuery(2);
      select('PARCELA_CT_PAGAR','','',' CONTA = :ID ', 'ID');
      parameters([IdConta], ['ID']);

    while QryFb.Eof = False do
      begin
        salvaDadosParcela(vlrField('ID'), vlrField('CONTA'), vlrField('VALOR'), vlrField('DATA_PAGAMENTO'), vlrField('DATA_VENCIMENTO'), vlrField('OBSERVACOES'));
        QryFb.Next;
      end;
    end;

  Result:= BaseResultadoParcela;
end;
// -----------------------------------------------------------------------------

procedure DBPagar.PreencheContas(Cbx: TComboBox);
begin
  Desp.despesaCombobox(Cbx);
end;


{$ENDREGION}

end.
