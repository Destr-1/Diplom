function PLUS(x:real):real; {������ ���祭�� x+}
begin
  if x>0 then plus:=x
         else plus:=0;
end;

{****************************************************************}
function ML(x:nar;l:mar;r:real):real;{������஢����� �㭪�� ���࠭��}
  var k:real;
      i:integer;
begin
  k:=0;
  ffi(x,fi);
  for i:=1 to m do
    k:=k+sqr(plus(fi[i]+l[i]/r));
  ML:=G(x)+r/2*k; {G(x)-�᭮���� �㭪�� ��������樨}
end;{ML}


{******************************************************************}
procedure LAGR;
{ ���������� G ��⮤�� ���䮢 � ������஢����� �㭪樥� ���࠭��:
    M(x,l,r)=f(x)+r/2*�㬬�(�� 1 �� m) ((fi[i](x)+l[i]/r)+)� }
  const q=2;
        e=0.00001; {�筮��� ���᫥���}
  var l,l1:mar;     {�����樥��� lambda ��� ������஢����� �㭪樨 ���࠭��}
      i:integer;    {���稪 横���}
      r,r1:real;{�����樥��� r ��� ������஢����� �㭪樨 ���࠭��}
      x,x1:nar;     {�窨 � ����࠭�⢥}
      t,t1:real;{�ᯮ����⥫�� ��६����}

{********************************************************************}
{ ����ﭨ� ����� �窠�� }
  function rast(x1,x2:nar):real;
    var k:real; i:integer;
    begin
      k:=0;
      for i:=1 to n do
        k:=k+sqr(x[i]-x1[i]);
      rast:=sqrt(k);
    end;
{$I Soprgrad}  {���᫥��� ����᫮����� �����㬠}
begin {LAGR}
  { ������� ��砫쭮�� ���祭�� l>=0, r>0 }
  for i:=1 to m do
    l1[i]:=0;
  r1:=20;
  SOPRGRAD(x1,l1,r1); { ��।��塞 ��� x �����㬠 �㭪樨 ML(x,l,r) }
  writeln('.');
  { ����塞 l1=(r0*fi(x)+l0)+ }
  l:=l1;
  ffi(x1,fi);
  for i:=1 to m do
    l1[i]:=plus(r1*fi[i]+l[i]);
  r:=r1;
  repeat
    x:=x1;
    { ��।��塞 ��� X min �㭪樨 ML(x,lk,rk) �� x � En}
    SOPRGRAD(x1,l1,r1);
    writeln('.');
    { �஢��塞 ᮡ���� ��ࠢ���⢠:
            S    fi[i](Xk)�     <         S   fi[i](Xk-1)�
     fi[i](Xk)+l(k)[i]/rk>0         fi[i](Xk-1)+l(k-1)[i]/r(k-1)>0
     �᫨ �믮�����, � r(k+1)=r(k)
     l(k+1)[i]=(r(k)*fi[i](Xk)+l(k)[i])+
     ���� l(k+1)=l(k) � r(k+1)=q*r(k);  q>1=const
     �த������ �� �� ��� ����   |X(k+1)-X(k)|>e
    }
    t:=0; t1:=0;
     ffi(x1,fi);
    for i:=1 to m do
      if (fi[i]+l1[i]/r1)>0 then t1:=t1+sqr(fi[i]);
    ffi(x,fi);
    for i:=1 to m do
      if (fi[i]+l[i]/r)>0 then t:=t+sqr(fi[i]);
    if t1<t then
      begin
        r:=r1;
        l:=l1;
        ffi(x1,fi);
        for i:=1 to m do
          l1[i]:=plus(r1*fi[i]+l[i]);
      end
    else
      begin
        l:=l1;
        r:=r1;
        r1:=r*q;
      end;
    writeln(rast(x,x1));
  until rast(x,x1)<e;
  writeln('�窠 min:');
  for i:=1 to n do
    writeln('x(',i,')=',x[i]);
  writeln('f(x)=',G(x),x[1],x[2]);
end; {LAGR}