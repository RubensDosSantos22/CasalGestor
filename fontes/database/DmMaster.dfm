object Dm: TDm
  Height = 423
  Width = 613
  object ConMySQL: TUniConnection
    ProviderName = 'mySQL'
    Port = 3306
    Database = 'heveasoft'
    Username = 'heveasoft'
    Server = 'mysql.heveasoft.com.br'
    LoginPrompt = False
    Left = 20
    Top = 25
    EncryptedPassword = '8CFF8BFF88FF9EFF8DFF9AFFCFFFCFFF'
  end
  object MsqlPrvd1: TMySQLUniProvider
    Left = 85
    Top = 25
  end
  object QrFBSelect1: TFDQuery
    Connection = Confb
    Left = 23
    Top = 82
  end
  object QrFBSelect2: TFDQuery
    Connection = Confb
    Left = 96
    Top = 82
  end
  object QrFBSelect3: TFDQuery
    Connection = Confb
    Left = 169
    Top = 82
  end
  object QrFBUpdate: TFDQuery
    Connection = Confb
    Left = 242
    Top = 82
  end
  object QrFBInsert: TFDQuery
    Connection = Confb
    Left = 310
    Top = 82
  end
  object QrFBDelete: TFDQuery
    Connection = Confb
    Left = 377
    Top = 82
  end
  object QrUnSelect1: TUniQuery
    Connection = ConMySQL
    Left = 24
    Top = 138
  end
  object QrUnSelect2: TUniQuery
    Connection = ConMySQL
    Left = 98
    Top = 138
  end
  object QrUnSelect3: TUniQuery
    Connection = ConMySQL
    Left = 173
    Top = 138
  end
  object QrUnInsert: TUniQuery
    Connection = ConMySQL
    Left = 318
    Top = 138
  end
  object QrUnUpdate: TUniQuery
    Connection = ConMySQL
    Left = 247
    Top = 138
  end
  object QrUnDelete: TUniQuery
    Connection = ConMySQL
    Left = 386
    Top = 138
  end
  object Confb: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ruben\OneDrive\Documentos\GitHub\CasalGestor\f' +
        'ontes\database\DATA.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 138
    Top = 24
  end
end
