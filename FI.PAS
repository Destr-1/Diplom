{  �᭮���� �㭪�� ��������樨
         G=G1+G2+G3+G4         }
{      x[1]=N1; x[2]=Q�1       }

function G1(x:nar):real;
{ ���᫥��� �㭪樨 �� ࠡ�� ��ࢮ�� ������� ��� ��-80/100-130/13 ���}
  begin
    {�᫨ �窠 (x[1],x[2]) ��室�� �� ������� ��।������, � ���祭��
    �㭪樨 ��ᢠ����� ᮮ⢥�����騥 㣫��� ��� �࠭��� ���祭��}
    if (x[1]<30) and (x[2]<0) then begin G1:=134; exit; end;
    if (x[1]<30) and (x[2]>150) then begin G1:=280; exit; end;
    if (x[1]>100) and (x[2]<0) then begin G1:=350; exit; end;
    if (x[1]>100) and (x[2]>150) then begin G1:=532; exit; end;
    if (x[1]<30) then begin G1:=BicubSpl1(30,x[2]); exit; end;
    if (x[1]>100) then begin G1:=BicubSpl1(100,x[2]); exit; end;
    if (x[2]<0) then begin G1:=BicubSpl1(x[1],0); exit; end;
    if (x[2]>150) then begin G1:=BicubSpl1(x[1],150); exit; end;
    G1:=BicubSpl1(x[1],x[2]);
  end;

function G(x:nar):real;
  begin
    G:=G1(x);
  end;

{***********************************************************************}
{  �㭪樨 - ��࠭�祭��:  }
{ 1,2. Nj min<=Nj<=Nj max
     x[1]=N1;  N1 min = 30;  N1 max = 100;}
function fi1(x:nar):real;
  begin
    fi1:=30-x[1];
  end;

function fi2(x:nar):real;
  begin
    fi2:=x[1]-100;
  end;

{ 3,4. 0<=Q�<=Q� max
       x[2]=Q�;  Q� max=150; }
function fi3(x:nar):real;
  begin
    fi3:=-x[2];
  end;

function fi4(x:nar):real;
  begin
    fi4:=x[2]-150;
  end;

{5,6. S� (Nj)<=Gj<=S� (Nj)
      �࠭��� ������ � ���� �㡨�᪨� ᯫ�����}


{****************************************************************************}


procedure ffi(x:nar;var fi:mar);
  begin
    fi[1]:=fi1(x);
    fi[2]:=fi2(x);
    fi[3]:=fi3(x);
    fi[4]:=fi4(x);
  end;