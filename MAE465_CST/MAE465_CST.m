%MAE CST Matrix Calculator
%Written by Ethan Covington and Nathan Phean
%input values
fprintf('Start node i in bottom left, work counterclockwise\n');
nodei = input('cord of nodei [x,y]\n');
nodej = input('cord of nodej [x,y]\n');
nodem = input('cord of nodem [x,y]\n');
E = input('E in Pa\n');
v = input('v\n');
t = input('thickness\n');
%Calculate B&G

%bi = yj-ym;
bi = nodej(2)-nodem(2);
%bj = ym-yi;
bj = nodem(2)-nodei(2);
%bm = yi-yj;
bm = nodei(2) - nodej(2);
%gi = xm - xj;
gi = nodem(1)-nodej(1);
%gj = xi - xm;
gj = nodei(1) - nodem(1);
%gm = xj - xi;
gm = nodej(1) - nodei(1);

%Calculate Area
a = 0.5*bj*gm;

%Calculate B matrix

B = (1/(2*a))*[bi 0 bj 0 bm 0;
               0 gi 0 gj 0 gm;
               gi bi gj bj gm bm;];
        
%Calculate C matrix

C  = (E/(1-v^2))*[1 v 0;
                v 1 0;
                0 0 (1-v)/2;];
            
%Calculate K matrix

K = t*a*transpose(B)*C*B;


%Calculate stresses

q = C*B*[0; 0.0025; 0.0012; 0; 0; 0.0025;];
