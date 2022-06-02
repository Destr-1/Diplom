program dover;
  uses printer;
  const u2=86; u1=42.5;{квантили распределения хи квадрат}
        u=1.960; { квантиль нормального распределения}
        na=63;ta=1.997;{ta - квантиль распределения Стьюдента}
  a:array [1..na] of byte=     (0,4,2,0,5,1,1,3,0,2,2,4,3,2,3,
                                 3,0,4,3,1,5,2,0,2,2,3,2,2,2,6,
                                 2,1,3,1,3,1,5,5,3,2,2,0,2,1,1,
                                 3,2,3,5,3,5,2,5,2,2,3,4,3,2,3,
                                 2,4,2);
  var s,s2,x1,k1,k2,s1:real;
      i:integer;
begin
  {Матожидание}
  x1:=0;
  for i:=1 to na do
    x1:=x1+a[i];
  x1:=x1/na;
  s2:=0;
  for i:=1 to na do
    s2:=s2+sqr(a[i]-x1); s1:=sqrt(s2/na);
  s2:=s2/(na-1);s:=sqrt(s2);
  writeln(lst,'Оценка матожидания');
  writeln(lst,'d - известна');
  writeln(lst,x1-u*s1/sqrt(na):8:5,' < m < ',x1+u*s1/sqrt(na):8:5);
  writeln(lst,'d - неизвестна');
  writeln(lst,x1-ta*s/sqrt(na):8:5,' < m < ',x1+ta*s/sqrt(na):8:5);
  {Дисперсия}
  k1:=(na-1)*s2/u2;
  k2:=(na-1)*s2/u1;
  writeln(lst,'Оценка дисперсии');
  writeln(lst,k1:8:5,' < d^2 < ',k2:8:5);
  writeln(lst,'Оценка квадратичного отклонения');
  writeln(lst,sqrt(k1):8:5,' < d < ',sqrt(k2):8:5);
end.


