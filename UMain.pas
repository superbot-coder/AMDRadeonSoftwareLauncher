unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Themes, Vcl.StdCtrls, Registry,
  Vcl.ExtCtrls, Winapi.ShellAPI, StrUtils, ProcessMod, Vcl.Menus,
  System.ImageList, Vcl.ImgList;

type
  TFrmMain = class(TForm)
    btnRun: TButton;
    StatText: TStaticText;
    RdGroupSwitch: TRadioGroup;
    MainMenu: TMainMenu;
    V1: TMenuItem;
    MM_Exit: TMenuItem;
    H1: TMenuItem;
    MM_OpenGitHub: TMenuItem;
    MM_OpenYouTube: TMenuItem;
    MM_OpenYouTube2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure RdGroupSwitchClick(Sender: TObject);
    procedure MM_ExitClick(Sender: TObject);
    procedure MM_OpenGitHubClick(Sender: TObject);
    procedure MM_OpenYouTubeClick(Sender: TObject);
    procedure MM_OpenYouTube2Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetRdGroupButton;
    Function GetAMDDriverInstalled: boolean;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  AMDInstalled   : Boolean;
  Reg            : TRegistry;
  SwitchNext     : Boolean;
  RSFullPathFile : String;

const
  PageGitHub   = 'https://github.com/superbot-coder/AMDRadeonSoftwareLauncher';
  PageYouTube  = 'https://www.youtube.com/channel/UC1A2rKV1Q92QlIhQOPkU7ZQ/videos';
  PageYouTube2 = 'https://www.youtube.com/user/antigosdep';
  key_amd_cn  = '\Software\AMD\CN';
  val_drv_ver = 'DriverVersion';
  val_cn_ver  = 'CNVersion';
  mb_caption  = '';

implementation

{$R *.dfm}

procedure TFrmMain.btnRunClick(Sender: TObject);
var
  PID: Integer;
  i: UInt8;
begin

  btnRun.Enabled := false;
  PID := FindProcessByExeName(RSFullPathFile, True);
  KillProcess(PID);

  for i := 1 to 10 do
  begin
    Application.ProcessMessages;
    sleep(100);
  end;

  ShellExecute(Handle, PChar('Open'), PChar(RSFullPathFile), Nil,
               PChar(ExtractFileDir(RSFullPathFile)), SW_SHOWNORMAL);

  btnRun.Enabled := true;

end;

procedure TFrmMain.MM_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MM_OpenGitHubClick(Sender: TObject);
begin
  ShellExecute(Handle, PChar('Open'), PChar(PageYouTube), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TFrmMain.MM_OpenYouTube2Click(Sender: TObject);
begin
  ShellExecute(Handle, PChar('Open'), PChar(PageYouTube2), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TFrmMain.MM_OpenYouTubeClick(Sender: TObject);
begin
  ShellExecute(Handle, PChar('Open'), PChar(PageYouTube), Nil, Nil, SW_SHOWNORMAL);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  TStyleManager.SetStyle('Ruby Graphite');
  RSFullPathFile := GetEnvironmentVariable('ProgramFiles') + '\AMD\CNext\CNext\RadeonSoftware.exe';

  if Not GetAMDDriverInstalled then
  begin
    RdGroupSwitch.Enabled    := false;
    btnRun.Enabled           := false;
    StatText.Visible         := true;
       //'Not found installed AMD Radeon Software. '
       //+ #13 + 'Please close this application';
  end;

  SetRdGroupButton;

end;

function TFrmMain.GetAMDDriverInstalled: boolean;
begin
  Result := false;
  if FileExists(RSFullPathFile) then
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      Result := Reg.KeyExists(key_amd_cn);
      AMDInstalled := Result;
    finally
      Reg.Free;
    end;
  end;
end;

procedure TFrmMain.RdGroupSwitchClick(Sender: TObject);
begin
  if SwitchNext then
  begin
    SwitchNext := False;
    Exit;
  end;

  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  try
    if Reg.OpenKey(key_amd_cn, false) then
    begin
      case (Sender as TRadioGroup).ItemIndex of
       0: begin
            Reg.RenameValue('_' + val_drv_ver, val_drv_ver);
            Reg.RenameValue('_' + val_cn_ver, val_cn_ver);
          end;
       1: begin
            Reg.RenameValue(val_drv_ver, '_' + val_drv_ver);
            Reg.RenameValue(val_cn_ver, '_' + val_cn_ver);
          end;
      end;
      Reg.CloseKey;
    end
    else
    begin

    end;
  finally
    Reg.Free;
  end;

  SetRdGroupButton;

end;

procedure TFrmMain.SetRdGroupButton;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly(key_amd_cn) then
    begin

      if Reg.ValueExists(val_drv_ver) and Reg.ValueExists(val_cn_ver) then
      begin
        if RdGroupSwitch.ItemIndex <> 0 then
        begin
          SwitchNext := true;
          RdGroupSwitch.ItemIndex := 0;
        end;
      end;

      if Reg.ValueExists('_' + val_drv_ver) and Reg.ValueExists('_' + val_cn_ver) then
      begin
        if RdGroupSwitch.ItemIndex <> 1 then
        begin
          SwitchNext := true;
          RdGroupSwitch.ItemIndex := 1;
        end;
      end;

      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

end.
