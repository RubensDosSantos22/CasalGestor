unit UnControleErros;

interface

uses
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
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Layouts,
  UnFrmErrosSistema,
   System.Generics.Collections;

type

    Erro = class
      function mensagemErro(Titulo, corpo: string; acoes: integer): Boolean;
    end;

    Aviso = class
      function mensagemAlerta(Titulo, corpo: string; acoes: Integer): Boolean;
    end;

    Mensagem = class
      function mensagemInformativa(Titulo, corpo, acoes: string): Boolean;
    end;

implementation

{ Erro }

function Erro.mensagemErro(Titulo, corpo: string; acoes: integer): Boolean;
begin
  FrmErroSistema := TFrmErroSistema.Create(Application);

  with FrmErroSistema do
    begin
      LblTituloErro.Text:= Titulo;
      LblDescricaoErro.Text:= corpo;
      //RctTituloErro.Fill.Color:= TAlphaColor.Red;

    if acoes = 0 then
      begin
        SpBtAcao2.Visible:= False;
      end
    else if acoes = 1 then
      begin
        SpBtAcao2.Visible:= True;
      end;

      ImgErro.Visible:= True;
      ImgAviso.Visible:= False;
      ShowModal;

      Result:= OpcaoSelecionada;
    end;
end;

{ Aviso }

function Aviso.mensagemAlerta(Titulo, corpo: string; acoes: Integer): Boolean;
begin
  FrmErroSistema := TFrmErroSistema.Create(Application);

  with FrmErroSistema do
    begin

    if Titulo <> '' then
      begin
        RctTituloErro.Visible:= True;
        LblTituloErro.Text:= Titulo;
      end
    else
      begin
        RctTituloErro.Visible:= False;
      end;

      LblDescricaoErro.Text:= corpo;

      //RctTituloErro.Fill.Color:= TAlphaColor.Red;

    if acoes = 0 then
      begin
        SpBtAcao2.Visible:= False;
      end
    else if acoes = 1 then
      begin
        SpBtAcao2.Visible:= True;
      end;

      ImgErro.Visible:= False;
      ImgAviso.Visible:= True;
      ShowModal;

      Result:= OpcaoSelecionada;
    end;
end;

{ Mensagem }

function Mensagem.mensagemInformativa(Titulo, corpo, acoes: string): Boolean;
begin
  //pass
end;

end.
