function PLUS(x:real):real; {вычисляет значение x+}
begin
  if x>0 then plus:=x
         else plus:=0;
end;

{****************************************************************}
function ML(x:nar;l:mar;r:real):real;{Модифицированная функция Лагранжа}
  var k:real;
      i:integer;
begin
  k:=0;
  ffi(x,fi);
  for i:=1 to m do
    k:=k+sqr(plus(fi[i]+l[i]/r));
  ML:=G(x)+r/2*k; {G(x)-основная функция минимизации}
end;{ML}


{******************************************************************}
procedure LAGR(var a2,b2,c2:real);
{ Минимизация G методом штрафов с модифицированной функцией Лагранжа:
    M(x,l,r)=f(x)+r/2*сумма(от 1 до m) ((fi[i](x)+l[i]/r)+)¤ }
  const q=2;
        e=0.1; {точность вычислений}
  var l,l1:mar;     {коэффициенты lambda для модифицированной функции Лагранжа}
      i:integer;    {счетчик циклов}
      r,r1:real;{коэффициенты r для модифицированной функции Лагранжа}
      x,x1:nar;     {точки в пространстве}
      t,t1:real;{вспомогательные переменные}

{********************************************************************}
{ расстояние между точками }
  function rast(x1,x2:nar):real;
    var k:real; i:integer;
    begin
      k:=0;
      for i:=1 to n do
        k:=k+sqr(x[i]-x1[i]);
      rast:=sqrt(k);
    end;
{$I Soprgrad}  {вычисление безусловного минимума}
begin {LAGR}
  { Задание начального значения l>=0, r>0 }
  for i:=1 to m do
    l1[i]:=0;
  r1:=20;
  SOPRGRAD(x1,l1,r1); { Определяем точку x минимума функции ML(x,l,r) }
  writeln('.');
  { Вычисляем l1=(r0*fi(x)+l0)+ }
  l:=l1;
  ffi(x1,fi);
  for i:=1 to m do
    l1[i]:=plus(r1*fi[i]+l[i]);
  r:=r1;
  repeat
    x:=x1;
    { определяем точку X min функции ML(x,lk,rk) по x в En}
    SOPRGRAD(x1,l1,r1);
    writeln('.');
    { Проверяем соблюдение неравенства:
            S    fi[i](Xk)¤     <         S   fi[i](Xk-1)¤
     fi[i](Xk)+l(k)[i]/rk>0         fi[i](Xk-1)+l(k-1)[i]/r(k-1)>0
     если выполнено, то r(k+1)=r(k)
     l(k+1)[i]=(r(k)*fi[i](Xk)+l(k)[i])+
     иначе l(k+1)=l(k) и r(k+1)=q*r(k);  q>1=const
     продолжаем до тех пор пока   |X(k+1)-X(k)|>e
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
  until rast(x,x1)<e;
  a2:=x[1];b2:=x[2];c2:=G(x);
end; {LAGR}