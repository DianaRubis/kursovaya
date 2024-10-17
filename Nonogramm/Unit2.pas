unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.jpeg;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    procedure Timer1Timer(Sender: TObject);



  private
  FFullText: string;
    FCurrentIndex: Integer;
  public
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit1;



procedure TForm3.Timer1Timer(Sender: TObject);
begin
  // Увеличиваем значение ProgressBar
  ProgressBar1.Position := ProgressBar1.Position + 15;
  Sleep(10);

  // Проверка заполнен ли ProgressBar
  if ProgressBar1.Position >= 100 then
  begin
    Timer1.Enabled := False; // Останавливаем таймер
    Form2.Show;
    Self.Close;
  end;
end;

end.
