%Axisymmetric calculations
fprintf('Start node i in bottom left, work counterclockwise\n');
nodei = input('cord of nodei/1 [x,y]\n');
nodej = input('cord of nodej/2 [x,y]\n');
nodem = input('cord of nodem/3 [x,y]\n');
E = input('E in Pa\n');
v = input('v\n');

%centroidal point
r = (nodei(1)+nodej(1)+nodem(1))/3;
z = (nodei(2)+nodej(2)+nodem(2))/3;
%Calculate A&B&G

%ai = rj*zm-zj*rm
ai = nodej(1)*nodem(2)-nodej(2)*nodem(1);
%bi = zj - zm
bi = nodej(2) - nodem(2);
%gi = rm - rj
gi = nodem(1) - nodej(1);
%aj = rm*zi - zm*ri
aj = nodem(1)*nodei(2) - nodem(2)*nodei(1);
%bj = zm - zi
bj = nodem(2) - nodei(2);
%gj = ri - rm
gj = nodei(1) - nodem(1);
%am = ri*zj - zi*rj
am = nodei(1)*nodej(2) - nodei(2)*nodej(1);
%bm = zi - zj
bm = nodei(2)-nodej(2);
%gm = rj - ri
gm = nodej(1)-nodei(1);


%Calculate Area
a = 0.5*bj*gm;

%Calculate B matrix

B = (1/(2*a))*[bi 0 bj 0 bm 0;
               0 gi 0 gj 0 gm;
               (ai/r+bi+gi*z/r) 0 (aj/r+bj+gj*z/r) 0 (am/r +bm + gm*z/r) 0;
               gi bi gj bj gm bm;];
        
%Calculate C matrix

C  = (E/((1+v)*(1-2*v)))*[1-v v v 0;
                         v 1-v v 0;
                         v v 1-v 0;
                         0 0 0 (1-2*v)/2;];
            
%Calculate K matrix

K = 2*pi*r*a*transpose(B)*C*B;

%Calculate stresses
%must manually insert {d}
q = C*B*[0.001; 0.0002; 0.0005; 0.0006; 0; 0;];