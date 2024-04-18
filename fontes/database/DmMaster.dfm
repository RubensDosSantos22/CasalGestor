object Dm: TDm
  Height = 529
  Width = 766
  PixelsPerInch = 120
  object ConMySQL: TUniConnection
    ProviderName = 'mySQL'
    Port = 3306
    Database = 'heveasoft'
    Username = 'heveasoft'
    Server = 'mysql.heveasoft.com.br'
    LoginPrompt = False
    Left = 25
    Top = 31
    EncryptedPassword = '8CFF8BFF88FF9EFF8DFF9AFFCFFFCFFF'
  end
  object MsqlPrvd1: TMySQLUniProvider
    Left = 106
    Top = 31
  end
  object QrFBSelect1: TFDQuery
    Left = 29
    Top = 102
  end
  object QrFBSelect2: TFDQuery
    Left = 120
    Top = 102
  end
  object QrFBSelect3: TFDQuery
    Left = 211
    Top = 102
  end
  object QrFBUpdate: TFDQuery
    Left = 302
    Top = 102
  end
  object QrFBInsert: TFDQuery
    Left = 388
    Top = 102
  end
  object QrFBDelete: TFDQuery
    Left = 471
    Top = 102
  end
  object QrUnSelect1: TUniQuery
    Connection = ConMySQL
    Left = 30
    Top = 173
  end
  object QrUnSelect2: TUniQuery
    Connection = ConMySQL
    Left = 123
    Top = 173
  end
  object QrUnSelect3: TUniQuery
    Connection = ConMySQL
    Left = 216
    Top = 173
  end
  object QrUnInsert: TUniQuery
    Connection = ConMySQL
    Left = 397
    Top = 173
  end
  object QrUnUpdate: TUniQuery
    Connection = ConMySQL
    Left = 309
    Top = 173
  end
  object QrUnDelete: TUniQuery
    Connection = ConMySQL
    Left = 482
    Top = 173
  end
  object Confb: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ruben\OneDrive\Documentos\Pessoal\Projetos\Cas' +
        'al Gestor\fontes\database\DATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 172
    Top = 30
  end
end
