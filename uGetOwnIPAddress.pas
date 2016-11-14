unit uGetOwnIPAddress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdUDPClient, IdStack, IdUDPBase, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    IdUDPClient1: TIdUDPClient;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    LocalAddresses: TStrings;
    function GetLocalAddress: TStrings;
    { Private �錾 }
  public
    { Public �錾 }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


function TForm1.GetLocalAddress():TStrings;
var
  LList: TIdStackLocalAddressList;
  LAddr: TIdStackLocalAddress;
  I: Integer;
  LocalAddresses: TStrings;
begin
  LocalAddresses := TStringList.Create;;
  LList := TIdStackLocalAddressList.Create;
  try
    GStack.GetLocalAddressList(LList);
    for I := 0 to LList.Count - 1 do
    begin
      LAddr := LList[I];
      if LAddr is TIdStackLocalAddressIPv4 then
      begin
        LocalAddresses.Add(TIdStackLocalAddressIPv4(LAddr).IPaddress);
      end;

      if LAddr is TIdStackLocalAddressIPv6 then
      begin
        LocalAddresses.Add(TIdStackLocalAddressIPv6(LAddr).IPaddress);
      end;
    end;

  finally
    LList.Free;
  end;

  Result := LocalAddresses;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  I: Integer;
  LocalAddress: String;
begin
  // ���݂�IP�A�h���X�ꗗ���擾����B
  LocalAddresses := GetLocalAddress;

  // Memo1 �̓��e���N���A���āAIP�A�h���X���������o���B
  Memo1.Lines.Clear;
  for i := 0  to LocalAddresses.Count - 1 do
  begin
    Memo1.Lines.Add(LocalAddresses[i]);
    LocalAddress  := LocalAddresses[i];
  end;

end;

// �t�H�[�����\�������Ƃ���IP�A�h���X����K���X�V����B
procedure TForm1.FormShow(Sender: TObject);
begin
  Button1Click(Sender);
end;

// ��莞�Ԃ��Ƃ�IP�A�h���X�����X�V����B
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Button1Click(Sender);
end;

end.
