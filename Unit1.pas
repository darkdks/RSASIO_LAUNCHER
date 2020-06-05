unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, shellapi, IOUtils,
  Inifiles, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TMain = class(TForm)
    btnMp: TButton;
    btnMult: TButton;
    btnCustomSongs: TButton;
    Image1: TImage;
    procedure btnMpClick(Sender: TObject);
    procedure btnMultClick(Sender: TObject);
    procedure btnCustomSongsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetConfigFileAndLaunch(Multiplayer: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;
  INPUTSWAP: String;
  DRIVERNAME: String;
  INIFILENAME: String;
  ROCKSMITHEXE: String;
  CUSTOMSONGSFOLDER: String;

implementation

{$R *.dfm}

procedure TMain.btnCustomSongsClick(Sender: TObject);
begin
  ShellExecute(0, 'explore', 'dlc\Custom\', '', '', SW_SHOWMAXIMIZED);
end;

procedure TMain.btnMpClick(Sender: TObject);

begin
  SetConfigFileAndLaunch(False)
end;

procedure TMain.btnMultClick(Sender: TObject);
begin
  SetConfigFileAndLaunch(True);
end;

procedure TMain.FormCreate(Sender: TObject);
var
  iniFile: TiniFIle;
  iniName: String;
begin
  iniName := TPath.GetFileNameWithoutExtension(Application.ExeName) + '.ini';
  if FileExists(iniName) then
  begin
    iniFile := TiniFIle.Create(ExtractFilePath(Application.ExeName) + iniName);
    try
      INIFILENAME := iniFile.ReadString('CONFIG', 'RSINI', '');
      INPUTSWAP := iniFile.ReadString('CONFIG', 'INPUTSWAP', '');
      DRIVERNAME := iniFile.ReadString('CONFIG', 'DRIVERNAME', '');
      ROCKSMITHEXE := iniFile.ReadString('CONFIG', 'ROCKSMITHEXE', '');
      CUSTOMSONGSFOLDER := iniFile.ReadString('CONFIG',
        'CUSTOMSONGSFOLDER', '');
      btnCustomSongs.Visible := CUSTOMSONGSFOLDER <> '';

    finally
      FreeAndNil(iniFile);
    end;
  end
  else
  begin
    ShowMessage(iniName + ' is missing' + #10#13 +
      'Make sure you extract the exe and ini file to the same location');
    Application.Terminate;
  end;
end;

procedure TMain.SetConfigFileAndLaunch(Multiplayer: Boolean);

var
  RS_ASIO: TStringList;
  i: Integer;
  ln: String;
begin
  if FileExists(INIFILENAME) then
  begin

    RS_ASIO := TStringList.Create;
    try
      RS_ASIO.LoadFromFile(INIFILENAME);
      for i := 0 to RS_ASIO.Count - 1 do
      begin
        ln := RS_ASIO.Strings[i];
        if ln = INPUTSWAP then
          if Multiplayer then
            RS_ASIO.Strings[i + 1] := 'Driver=' + DRIVERNAME
          else
            RS_ASIO.Strings[i + 1] := 'Driver='
      end;

    finally
      RS_ASIO.SaveToFile(INIFILENAME);
      FreeAndNil(RS_ASIO)
    end;

    if FileExists(ROCKSMITHEXE) then
      ShellExecute(0, 'open', PWideChar(ROCKSMITHEXE), '', '', SW_SHOWNORMAL)
    else
      ShowMessage(ROCKSMITHEXE + ' is missing' + #10#13 +
        'Make sure you extract this app to RockSmith folder');

  end
  else
  begin
    ShowMessage(INIFILENAME + ' is missing' + #10#13 +
      'Make sure you extract this app to RockSmith folder');

  end;
  Application.Terminate;
end;

end.
