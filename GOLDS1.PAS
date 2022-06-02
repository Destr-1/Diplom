function goldsech(x,s:nar):real;
{Метод золотого сечения}
{  const e=1.0E-10;}
  var k1,k2,y1,y2,a,b,u1,u2:real;
      h:integer;
      b1:boolean;

  function f1(l2:real):real;
  var k:nar;
      i:integer;
  begin
    FillChar(k,SizeOf(k),0);
    for i:=1 to n do
      k[i]:=x[i]+l2*s[i];
    f1:=f(k);
  end;

begin
  h:=1;
  k1:=0.0; y1:=f1(k1);
  k2:=1.0; y2:=f1(k2);
  b1:=true;
  if y2=y1 then b1:=false;
  while b1 do
    begin
      if f1(k2+h)<f1(k2) then begin k1:=k2; k2:=k2+h; end;
      if f1(k2+h)=f1(k2) then begin k1:=k2; k2:=k2+h; b1:=false; end;
      if f1(k2+h)>f1(k2) then begin k2:=k2+h; b1:=false; end;
    end;
  a:=k1; b:=k2;
  u1:=a+(3-sqrt(5))*(b-a)/2;
  u2:=a+b-u1;
  i:=0;
  while abs(a-b)>e do
    if f1(u1)<=f1(u2) then begin inc(i);b:=u2;u2:=u1;u1:=a+b-u2;end
    else begin a:=u1;u1:=u2;u2:=a+b-u1;inc(i)end;
  goldsech:=u1;
{  if h<0 then begin a:=k2; b:=k1; end
  else begin a:=k1; b:=k2; end;
  u1:=a+(3-sqrt(5))*(b-a)/2;
  u2:=a+(sqrt(5)-1)*(b-a)/2;
  i:=0;
  while abs(a-b)>e do
    if f(u1)>=f(u2) then begin inc(i);a:=u1; u1:=u2;u2:=a+(sqrt(5)-1)*(b-a)/2;;end
    else begin b:=u2;u2:=u1;u1:=a+(3-sqrt(5))*(b-a)/2;;inc(i);end;
  writeln('min=',f(u1),' при x=',u1,'   ',f(a),'  ',f(b));
  readln;}
end;



