numElements = input('Number of elements\n');
E = input('E in Pa\n');
v = input('v\n');
t = input('thickness\n');
for k = 1:numElements

    fprintf('Start node i in bottom left, work counterclockwise\n');
element(k).nodei = input('cord of nodei [x,y]\n');
element(k).nodej = input('cord of nodej [x,y]\n');
element(k).nodem = input('cord of nodem [x,y]\n');

%Calculate B&G

%bi = yj-ym;
element(k).bi = element(k).nodej(2)-element(k).nodem(2);
%bj = ym-yi;
element(k).bj = element(k).nodem(2)-element(k).nodei(2);
%bm = yi-yj;
element(k).bm = element(k).nodei(2) - element(k).nodej(2);
%gi = xm - xj;
element(k).gi = element(k).nodem(1)-element(k).nodej(1);
%gj = xi - xm;
element(k).gj = element(k).nodei(1) - element(k).nodem(1);
%gm = xj - xi;
element(k).gm = element(k).nodej(1) - element(k).nodei(1);

%Calculate Area
element(k).a = 0.5*element(k).bj*element(k).gm;

%Calculate B matrix

element(k).B = (1/(2*element(k).a))*[element(k).bi 0 element(k).bj 0 element(k).bm 0;
               0 element(k).gi 0 element(k).gj 0 element(k).gm;
               element(k).gi element(k).bi element(k).gj element(k).bj element(k).gm element(k).bm;];
        
%Calculate C matrix

element(k).C  = (E/(1-v^2))*[1 v 0;
                v 1 0;
                0 0 (1-v)/2;];
            
%Calculate K matrix

element(k).K = t*element(k).a*transpose(element(k).B)*element(k).C*element(k).B;

%Calculate stresses
%{d} must be manually inputted
element(k).q = element(k).C*element(k).B*[0; 0.0025; 0.0012; 0; 0; 0.0025;];


end


