{
  This file contains functions for saving and loading text files.
  Encoding is detected on loading.

  Note: encoding detecion is based on TEncoding.GetBufferEncoding which
  checks only encoding signatures (if they exist in files).
  If no signature:
  - Windows: ANSI encoding is returned. We perform additional checks, maybe
    it cannot be ANSI encoding, and use UTF 16 LE in this case.
  - other OS: UTF-8 is returned.

  The main thing that can be improved: checking for UTF-8 without signature.
}

unit TextFileFunc;

interface

uses
  System.Classes, System.SysUtils,
  fmxRichView, fmxRVEdit, fmxRVTypes, fmxRVUni;

// Loading text from Stream in rve, detecting text encoding and returning it in Enc
function LoadTextFromStreamAuto(rve: TCustomRichView; Stream: TStream;
  out Enc: TEncoding): Boolean;
// The same from file
function LoadTextFromFileAuto(rve: TCustomRichView;
  FileName: TRVUnicodeString; out Enc: TEncoding): Boolean;
// Inserting text from Stream in rve, detecting text encoding
function InsertTextFromStreamAuto(rve: TCustomRichViewEdit; Stream: TStream): Boolean;
// The same from file
function InsertTextFromFileAuto(rve: TCustomRichViewEdit;
  FileName: TRVUnicodeString): Boolean;
// Saving rve as text with encoding Enc to Stream
function SaveEncodedTextToStream(rve: TCustomRichView; const Path: TRVUnicodeString;
  Stream: TStream; Enc: TEncoding): Boolean;
// The same to file
function SaveEncodedTextToFile(rve: TCustomRichView; const FileName: TRVUnicodeString;
  Enc: TEncoding): Boolean;

implementation

// Converts Stream to Unicode (UTF-16 LE)
function ConvertStreamToUnicode(var Stream: TBytesStream; out Enc: TEncoding): Boolean;
var
  Bytes: TBytes;
begin
  Result := False;
  try
    Enc := nil;
    TEncoding.GetBufferEncoding(Stream.Bytes, Enc);
    {$IFDEF MSWINDOWS}
    // GetBufferEncoding checks only signatures.
    // RV_TestStreamUnicode does additional checks
    if Enc = TEncoding.Default then
    begin
      Stream.Position := 0;
      if RV_TestStreamUnicode(Stream) = rvutYes then
        Enc := TEncoding.Unicode;
    end;
    {$ENDIF}
    if Enc <> TEncoding.Unicode then
    begin
      Bytes := TEncoding.Convert(Enc, TEncoding.Unicode, Stream.Bytes, 0, Stream.Size);
      Stream.Free;
      Stream := TBytesStream.Create(nil);
      if Length(Bytes) > 0 then
        Stream.WriteBuffer(Bytes[0], Length(Bytes));
    end;
    Result := True;
  except
    Enc := TEncoding.Default;
  end;
end;
{------------------------------------------------------------------------------}
function LoadTextFromStreamAuto(rve: TCustomRichView; Stream: TStream;
  out Enc: TEncoding): Boolean;
var
  BStream: TBytesStream;
begin
  BStream := nil;
  try
    if Stream is TBytesStream then
      BStream := TBytesStream(Stream)
    else
    begin
      BStream := TBytesStream.Create(nil);
      BStream.CopyFrom(Stream, 0);
    end;
    Result := ConvertStreamToUnicode(BStream, Enc);
    if not Result then
      exit;
    BStream.Position := 0;
    Result := rve.LoadTextFromStreamW(BStream, 0, 0, False);
  finally
    if BStream <> Stream then
      BStream.Free;
  end;
end;
{------------------------------------------------------------------------------}
function LoadTextFromFileAuto(rve: TCustomRichView;
  FileName: TRVUnicodeString; out Enc: TEncoding): Boolean;
var
  Stream: TFileStream;
begin
  Result := False;
  try
    Stream := TFileStream.Create(FileName, fmOpenRead);
    try
      Result := LoadTextFromStreamAuto(rve, Stream, Enc);
    finally
      Stream.Free;
    end;
  except
    Enc := TEncoding.Default;
  end;
end;
{------------------------------------------------------------------------------}
function InsertTextFromStreamAuto(rve: TCustomRichViewEdit; Stream: TStream): Boolean;
var
  BStream: TBytesStream;
  Enc: TEncoding;
begin
  BStream := nil;
  try
    if Stream is TBytesStream then
      BStream := TBytesStream(Stream)
    else
    begin
      BStream := TBytesStream.Create(nil);
      BStream.CopyFrom(Stream, 0);
    end;
    Result := ConvertStreamToUnicode(BStream, Enc);
    if not Result then
      exit;
    BStream.Position := 0;
    Result := rve.InsertTextFromStreamW(BStream);
  finally
    if BStream <> Stream then
      BStream.Free;
  end;
end;
{------------------------------------------------------------------------------}
function InsertTextFromFileAuto(rve: TCustomRichViewEdit;
  FileName: TRVUnicodeString): Boolean;
var
  Stream: TFileStream;
begin
  Result := False;
  try
    Stream := TFileStream.Create(FileName, fmOpenRead);
    try
      Result := InsertTextFromStreamAuto(rve, Stream);
    finally
      Stream.Free;
    end;
  except
  end;
end;
{------------------------------------------------------------------------------}
function SaveEncodedTextToStream(rve: TCustomRichView; const Path: TRVUnicodeString;
  Stream: TStream; Enc: TEncoding): Boolean;
var
  BStream: TBytesStream;
  Bytes: TBytes;
begin
  Result := False;
  try
    if Enc = TEncoding.Unicode then
    begin
      if not rve.SaveTextToStreamW('', Stream, 80, False, False, True) then
        exit;
    end
    else
    begin
      BStream := TBytesStream.Create(nil);
      try
        if not rve.SaveTextToStreamW('', BStream, 80, False, False, False) then
          exit;
        Bytes := Enc.GetPreamble;
        if Length(Bytes) > 0 then
          Stream.WriteBuffer(Bytes[0], Length(Bytes));
        Bytes := TEncoding.Convert(TEncoding.Unicode, Enc, BStream.Bytes, 0, BStream.Size);
        if Length(Bytes) > 0 then
          Stream.WriteBuffer(Bytes[0], Length(Bytes));
      finally
        BStream.Free;
      end;
    end;
    Result := True;
  except
  end;
end;
{------------------------------------------------------------------------------}
function SaveEncodedTextToFile(rve: TCustomRichView; const FileName: TRVUnicodeString;
  Enc: TEncoding): Boolean;
var
  Stream: TFileStream;
begin
  Result := False;
  try
    Stream := TFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    Result := SaveEncodedTextToStream(rve, ExtractFilePath(FileName), Stream, Enc);
    Stream.Free;
  except
  end;
end;

end.
