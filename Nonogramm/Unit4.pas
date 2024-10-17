unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TForm5 = class(TForm)
  GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    rbEasyLevel1: TRadioButton;
    rbEasyLevel2: TRadioButton;
    rbEasyLevel3: TRadioButton;
    rbMediumLevel1: TRadioButton;
    rbMediumLevel2: TRadioButton;
    rbMediumLevel3: TRadioButton;
    rbHardLevel1: TRadioButton;
    rbHardLevel2: TRadioButton;
    rbHardLevel3: TRadioButton;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure LoadLevelFile(const FileName: string);
    procedure FormShow(Sender: TObject);



  private
  FileName: string;


    { Private declarations }
  public

  FilePath:string;
   procedure UnlockLevels;

  end;

var
  Form5: TForm5;
   LevelsCompleted: Integer = 0;




implementation



{$R *.dfm}

uses Unit1, Unit3;



procedure TForm5.FormCreate(Sender: TObject);
begin
GroupBox1.Font.Name := 'Ink Free';
GroupBox2.Font.Name := 'Ink Free';
GroupBox3.Font.Name := 'Ink Free';



  rbEasyLevel1.OnClick := RadioButtonClick;
  rbEasyLevel2.OnClick := RadioButtonClick;
  rbEasyLevel3.OnClick := RadioButtonClick;
  rbMediumLevel1.OnClick := RadioButtonClick;
  rbMediumLevel2.OnClick := RadioButtonClick;
  rbMediumLevel3.OnClick := RadioButtonClick;
  rbHardLevel1.OnClick := RadioButtonClick;
  rbHardLevel2.OnClick := RadioButtonClick;
  rbHardLevel3.OnClick := RadioButtonClick;
end;





procedure TForm5.FormShow(Sender: TObject);
begin
  rbEasyLevel1.Checked := False;
  rbEasyLevel2.Checked := False;
  rbEasyLevel3.Checked := False;
  rbMediumLevel1.Checked := False;
  rbMediumLevel2.Checked := False;
  rbMediumLevel3.Checked := False;
  rbHardLevel1.Checked := False;
  rbHardLevel2.Checked := False;
  rbHardLevel3.Checked := False;
end;






procedure TForm5.UnlockLevels;
begin

  if Form4.LevelsCompleted >= 1 then
  begin
    rbEasyLevel1.Enabled := False;

  end;
  if Form4.LevelsCompleted >= 2 then
  begin
    rbEasyLevel2.Enabled := False;

  end;
  if Form4.LevelsCompleted >= 3 then
  begin
    GroupBox2.Enabled := True;
    GroupBox2.Visible := True;
    rbEasyLevel3.Enabled := False;
    GroupBox2.Repaint;
  end;
  if Form4.LevelsCompleted >= 4 then
  begin
    rbMediumLevel1.Enabled := False;
  end;
  if Form4.LevelsCompleted >= 5 then
  begin
    rbMediumLevel2.Enabled := False;
  end;
  if Form4.LevelsCompleted >= 6 then
  begin
    GroupBox3.Enabled := True;
    GroupBox3.Visible := True;
    rbMediumLevel3.Enabled := False;
    GroupBox3.Repaint;
  end;
  if Form4.LevelsCompleted >= 7 then
  begin
    rbHardLevel1.Enabled := False;
  end;
  if Form4.LevelsCompleted >= 8 then
  begin
    rbHardLevel2.Enabled := False;
  end;
  if Form4.LevelsCompleted >= 9 then
  begin
    rbHardLevel3.Enabled := False;
  end;
end;






procedure TForm5.RadioButtonClick(Sender: TObject);
var
  FileName: string;
begin
  if Sender = rbEasyLevel1 then
    FileName := 'EasyLevel1'
  else if Sender = rbEasyLevel2 then
    FileName := 'EasyLevel2'
  else if Sender = rbEasyLevel3 then
    FileName := 'EasyLevel3'
  else if Sender = rbMediumLevel1 then
    FileName := 'MediumLevel1'
  else if Sender = rbMediumLevel2 then
    FileName := 'MediumLevel2'
  else if Sender = rbMediumLevel3 then
    FileName := 'MediumLevel3'
  else if Sender = rbHardLevel1 then
    FileName := 'HardLevel1'
  else if Sender = rbHardLevel2 then
    FileName := 'HardLevel2'
  else if Sender = rbHardLevel3 then
    FileName := 'HardLevel3';
  LoadLevelFile(FileName);
end;


procedure TForm5.LoadLevelFile(const FileName: string);
var
  LevelsPath, FullPath, FullPathC, FullPathR: string;
begin
  LevelsPath := ExtractFilePath(Application.ExeName);
  LevelsPath := IncludeTrailingPathDelimiter(LevelsPath) + 'levels\';
  FullPath := LevelsPath + FileName + '\reshenie.txt';
  FullPathC := LevelsPath + FileName + '\gridC.txt';
  FullPathR := LevelsPath + FileName + '\gridR.txt';




  if not FileExists(FullPath) then
  begin
    ShowMessage('Файл не найден: ' + FullPath);
    Exit;
  end;

  if not Assigned(Form4) then
    Form4 := TForm4.Create(Application);

  Form4.FilePath := FullPath; // Передача пути к файлу
  Form4.LoadLevelFromFile(FullPathC, FullPathR, Form4.StringGrid1); // Передача путей к файлам для столбцов и строк
  Form4.Show;
  Form5.Hide;
end;







end.
