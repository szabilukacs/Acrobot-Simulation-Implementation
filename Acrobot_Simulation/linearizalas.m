
function [A,B] = linearizalas(m1,m2,l1,l2,lc1,lc2,J1,J2)

g = 9.81;
c1 = m1*lc1^2+m2*l1^2+J1;
c2 = m2*lc2^2+J2;
c3 = m2*l1*lc2;
k1 = (m1*lc1 + m2*l1)*g;
k2 = m2*lc2*g;

Seged = inv([c1+c2+2*c3 c2+c3;
    c2+c3 c2]);

a11 = Seged(1,1);
a12 = Seged(1,2);
a21 = Seged(2,1);
a22 = Seged(2,2);

A1 = a11*(k1+k2)+a12*k2;
A2 = (a11 + a12)*k2;
A3 = a12*(k1+k2) + a22*k2;
A4 = (a12 + a22)*k2;

A = [A1 A2; A3 A4];

A = [zeros(2) eye(2);
    A zeros(2)];

B = [0;0;a12;a22];

end




