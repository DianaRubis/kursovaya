unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);


  private
  FForm3Shown:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;


implementation

{$R *.dfm}


uses Unit2, Unit3, Unit4;







procedure TForm2.FormCreate(Sender: TObject);
begin
SpeedButton1.Font.Name := 'Ink Free';
SpeedButton3.Font.Name := 'Ink Free';
SpeedButton2.Font.Name := 'Ink Free'
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  if not FForm3Shown then
  begin
    Form3.ShowModal;
    FForm3Shown := True;
  end;
end;



procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
Form2.Hide;
Form5.Show;
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
Close;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
ShowMessage('Разработала учащаяся группы ПЗТ-41 Рубис Диана' + #13 + 'Курсовое проект: игровое приложение "Нонограммы"');
end;

end.
