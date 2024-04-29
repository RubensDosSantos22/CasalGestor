unit UnDBcontasAReceber;

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

    {$REGION 'Declarações do controlador'}

   TConta = class
     private
        TId: Integer;
        TIdTabela: integer;
        TCodigoConta: string;
        TValor: Double;
        TRecebimento: TDate;
        TVencimento: TDAte;
        TReceita: Integer;
        TObservacoes: string;
        TCReated: TDateTime;
        TUpdated: TDateTime;
     public
        property Id                          : Integer      read TId           write TId;
        property IdTabela                    : Integer      read TIdTabela     write TIdTabela;
        property CodigoConta                 : string       read TCodigoConta  write TCodigoConta;
        property Valor                       : Double       read TValor        write TValor;
        property Recebimento                 : TDate        read TRecebimento  write TRecebimento;
        property Vencimento                  : TDate        read TVencimento   write TVencimento;
        property Receita                     : Integer      read TReceita      write TReceita;
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
        TRecebimento: TDate;
        TObservacoes: string;
     public
        property Id                          : Integer      read TId           write TId;
        property IdTabela                    : Integer      read TIdTabela     write TIdTabela;
        property Conta                       : Integer      read TIdConta      write TIdConta;
        property Valor                       : Double       read TValor        write TValor;
        property Recebimento                 : TDate        read TRecebimento    write TRecebimento;
        property Observacoes                 : string       read TObservacoes  write TObservacoes;
   end;

   comboItem = class(TListBoxItem)
      private
        iid: integer;
        itext: string;
      public
        property id: integer read iid write iid;
        property Text: string read itext write itext;
      end;

    DBReceber = class

      //Salvamento
      procedure SalvaConta(conta: string; valor: Double; Recebimento, Vencimento: TDate; RECEITA: Integer; Obs: string; id: integer = 0);
      procedure SalvaParcela(IdConta: integer; valor: Double; Recebimento: TDate; Obs: string; id: integer = 0);

      //Exclusão
      procedure DeletaConta(idConta: integer);
      procedure DeletaParcela(IdParcela: integer);

      //Consulta
      function PesquisarContas(TipoData: Integer; Inicio, Fim: TDate): TList<TConta>;
      function PesquisarParcelas(IdConta: integer): TList<TParcela>;

      procedure PreencheContas(Cbx: TComboBox);

    private
      //Salvamento dos dados
      procedure salvaDadosConta(tbId: Integer; tbConta: string; tbValor: Double; tbRECEBIMENTO, tbVencimento: TDate; tbRECEITA: Integer; tbObservacoes: string; tbCreated, tbUpdated: TDateTime);
      procedure salvaDadosParcela(tbId, tbConta: integer; tbValor: Double; tbRECEBIMENTO: TDate; tbObservacoes: string);
    end;

  {$ENDREGION}

var
   BaseResultadoConta                     : TList<TConta>;
   BaseResultadoParcela                   : TList<TParcela>;
   Cons: Query;
   i: Integer;
   ic: comboItem;


implementation


    {$REGION 'Procedimentos privados'}

procedure DBReceber.salvaDadosConta(tbId: Integer; tbConta: string; tbValor: Double; tbRECEBIMENTO, tbVencimento: TDate; tbRECEITA: Integer; tbObservacoes: string; tbCreated, tbUpdated: TDateTime);
begin

  BaseResultadoConta.Add(TConta.Create);

  with BaseResultadoConta[i] do
    begin
      id                  := i;
      IdTabela            := tbId;
      CodigoConta         := tbConta;
      Valor               := tbValor;
      Recebimento         := tbRecebimento;
      Vencimento          := tbVencimento;
      RECEITA             := tbRECEITA;
      Observacoes         := tbObservacoes;
      Created             := tbCreated;
      Updated             := tbUpdated;
    end;

    i:= i + 1;
end;

procedure DBReceber.salvaDadosParcela(tbId, tbConta: integer; tbValor: Double; tbRECEBIMENTO: TDate; tbObservacoes: string);
begin

  BaseResultadoParcela.Add(TParcela.Create);

  with BaseResultadoParcela[i] do
    begin
      id                  := i;
      IdTabela            := tbId;
      Conta               := tbConta;
      Valor               := tbValor;
      RECEBIMENTO           := tbRECEBIMENTO;
      Observacoes         := tbObservacoes;
    end;

    i:= i + 1;
end;

{$ENDREGION}

    {$REGION 'Procedimentos Públicos'}

// Salvamento ------------------------------------------------------------------

procedure DBReceber.SalvaConta(conta: string; valor: Double; RECEBIMENTO,
  Vencimento: TDate; RECEITA: Integer; Obs: string; id: integer = 0);
var
   pagto, vencto: string;
begin

  pagto:= DateToStr(RECEBIMENTO);
  pagto:= Copy(pagto, 4, 2) + '/' + Copy(pagto, 0, 2) + '/' + Copy(pagto, 7, 4);

  vencto:= DateToStr(Vencimento);
  vencto:= Copy(vencto, 4, 2) + '/' + Copy(vencto, 0, 2) + '/' + Copy(vencto, 7, 4);

  with Cons.FB do
    begin

      command_fields:= ['CODIGO_CONTA', 'VALOR_RECEBIMENTO', 'DATA_RECEBIMENTO', 'DATA_VENCIMENTO', 'RECEITA', 'OBSERVACOES'];

    if id = 0 then
      begin
        insert('CT_RECEBER', command_fields);
      end
    else
      begin
        update('CT_RECEBER', command_fields, id);
      end;

      parameters([conta, valor, pagto, vencto, RECEITA, obs], command_fields);
    end;
end;

procedure DBReceber.SalvaParcela(IdConta: integer; valor: Double;
  RECEBIMENTO: TDate; Obs: string; id: integer = 0);
begin

  with Cons.FB do
    begin

      command_fields:= ['CONTA', 'VALOR', 'DATA_RECEBIMENTO', 'OBSERVACOES'];

    if id = 0 then
      begin
        insert('PARCELA_CT_RECEBER', command_fields);
      end
    else
      begin
        update('PARCELA_CT_RECEBER', command_fields, id);
      end;

      parameters([Idconta, valor, RECEBIMENTO, obs], command_fields);
    end;
end;

// -----------------------------------------------------------------------------

// Exclusão --------------------------------------------------------------------

procedure DBReceber.DeletaConta(idConta: integer);
begin
  Cons.FB.delete('CT_RECEBER', '', idConta);
end;

procedure DBReceber.DeletaParcela(idParcela: integer);
begin
  Cons.FB.delete('PARCELA_CT_RECEBER', '', idParcela);
end;

// -----------------------------------------------------------------------------

// Consulta --------------------------------------------------------------------
function DBReceber.PesquisarContas(TipoData: Integer; Inicio,
  Fim: TDate): TList<TConta>;
var
   Campo_Data: string;
   dtInicial, dtFinal: string;
begin

  i:= 0;

  if TipoData = 0 then
    Campo_Data:= 'DATA_VENCIMENTO'
  else
    Campo_Data:= 'DATA_RECEBIMENTO';

  BaseResultadoConta:= TList<TConta>.Create;

  with Cons.FB do
    begin
      dtInicial:= DateToStr(Inicio);
      dtInicial:= Copy(dtInicial, 4, 2) + '/' + Copy(dtInicial, 0, 2) + '/' + Copy(dtInicial, 7, 4);

      dtFinal:= DateToStr(Fim);
      dtFinal:= Copy(dtFinal, 4, 2) + '/' + Copy(dtFinal, 0, 2) + '/' + Copy(dtFinal, 7, 4);

      setQuery(1);
      select('CT_RECEBER','','',Campo_Data + ' BETWEEN :INICIO AND :FIM ', Campo_Data);
      parameters([dtInicial, dtFinal], ['INICIO', 'FIM']);

    if QryFb.Eof = False then
      begin

      while QryFb.Eof = False do
        begin
          salvaDadosConta(vlrField('ID'), vlrField('CODIGO_CONTA'), vlrField('VALOR_RECEBIMENTO'), vlrField('DATA_RECEBIMENTO'), vlrField('DATA_VENCIMENTO'), vlrField('RECEITA'), vlrField('OBSERVACOES'), vlrField('CREATED_AT'), vlrField('UPDATED_AT'));
          QryFb.Next;
        end;
      end
    else
      begin
        ShowMessage('NÃO HÁ LANÇAMENTOS PARA O PERÍODO SELECIONADO');
      end;
    end;

  Result:= BaseResultadoConta;
end;

function DBReceber.PesquisarParcelas(IdConta: integer): TList<TParcela>;
begin
  i:= 0;

  BaseResultadoParcela:= TList<TParcela>.Create;

  with Cons.FB do
    begin

      setQuery(2);
      select('CT_RECEBER','','',' ID = :ID ', 'ID');
      parameters([IdConta], ['ID']);

    while QryFb.Eof = False do
      begin
        salvaDadosParcela(vlrField('ID'), vlrField('CONTA'), vlrField('VALOR'), vlrField('DATA_RECEBIMENTO'), vlrField('OBSERVACOES'));
        QryFb.Next;
      end;
    end;

  Result:= BaseResultadoParcela;
end;
// -----------------------------------------------------------------------------

procedure DBReceber.PreencheContas(Cbx: TComboBox);
var
  index: integer;
begin

  with Cons.FB do
    begin

      setQuery(3);
      select('TP_RECEITA','','','', 'ID');

    while QryFb.Eof = False do
      begin

        index:= vlrField('ID');
        Cbx.Items.AddObject(vlrField('NOME'), TObject(index));
        QryFb.Next;
      end;
    end;
end;


{$ENDREGION}


end.
