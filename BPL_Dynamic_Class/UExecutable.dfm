object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 609
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    624
    609)
  TextHeight = 15
  object Edit1: TEdit
    Left = 96
    Top = 112
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 360
    Top = 112
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 224
    Top = 176
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object Button1: TButton
    Left = 96
    Top = 256
    Width = 121
    Height = 25
    Caption = 'Somar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 360
    Top = 256
    Width = 121
    Height = 25
    Caption = 'Subtrair'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 327
    Width = 608
    Height = 274
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
    ExplicitWidth = 606
    ExplicitHeight = 266
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 267
    Top = 24
  end
end
