object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Radeon Software Launcher '
  ClientHeight = 159
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    373
    159)
  PixelsPerInch = 96
  TextHeight = 13
  object btnRun: TButton
    Left = 64
    Top = 113
    Width = 251
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Restart AMD Radeon Software'
    TabOrder = 0
    OnClick = btnRunClick
  end
  object StatText: TStaticText
    Left = 78
    Top = 79
    Width = 265
    Height = 28
    AutoSize = False
    Caption = 
      'Not found installed AMD Radeon Software. '#13#10'Please close this app' +
      'lication'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object RdGroupSwitch: TRadioGroup
    Left = 40
    Top = 8
    Width = 289
    Height = 65
    Items.Strings = (
      'Version enabled (Normal)'
      'Version Disabled (Patched)')
    TabOrder = 2
    OnClick = RdGroupSwitchClick
  end
  object MainMenu: TMainMenu
    Left = 272
    Top = 16
    object V1: TMenuItem
      Caption = 'Main'
      object MM_Exit: TMenuItem
        Caption = 'Exit'
        OnClick = MM_ExitClick
      end
    end
    object H1: TMenuItem
      Caption = 'Help'
      object MM_OpenGitHub: TMenuItem
        Caption = 'Open the project page on GitHub'
        ImageIndex = 1
        OnClick = MM_OpenGitHubClick
      end
      object MM_OpenYouTube: TMenuItem
        Caption = 'Open the channel page "'#1059#1084#1077#1083#1077#1094' TV" on YouTube'
        OnClick = MM_OpenYouTubeClick
      end
      object MM_OpenYouTube2: TMenuItem
        Caption = 'Open the channel page "Delphi - '#1089#1086#1092#1090' '#1089#1074#1086#1080#1084#1080' '#1088#1091#1082#1072#1084#1080'" on YouTube'
        OnClick = MM_OpenYouTube2Click
      end
    end
  end
end
