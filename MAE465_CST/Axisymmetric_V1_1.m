numElements = input('Number of elements\n');
E = input('E in Pa\n');
v = input('v\n');


for k = 1:numElements
%Axisymmetric calculations
fprintf('Start node i in bottom left, work counterclockwise\n');
element(k).nodei = input('cord of nodei/1 [x,y]\n');
element(k).nodej = input('cord of nodej/2 [x,y]\n');
element(k).nodem = input('cord of nodem/3 [x,y]\n');

%centroidal point
element(k).r = (element(k).nodei(1)+element(k).nodej(1)+element(k).nodem(1))/3;
element(k).z = (element(k).nodei(2)+element(k).nodej(2)+element(k).nodem(2))/3;
%Calculate A&B&G

%ai = rj*zm-zj*rm
element(k).ai = element(k).nodej(1)*element(k).nodem(2)-element(k).nodej(2)*element(k).nodem(1);
%bi = zj - zm
element(k).bi = element(k).nodej(2) - element(k).nodem(2);
%gi = rm - rj
element(k).gi = element(k).nodem(1) - element(k).nodej(1);
%aj = rm*zi - zm*ri
element(k).aj = element(k).nodem(1)*element(k).nodei(2) - element(k).nodem(2)*element(k).nodei(1);
%bj = zm - zi
element(k).bj = element(k).nodem(2) - element(k).nodei(2);
%gj = ri - rm
element(k).gj = element(k).nodei(1) - element(k).nodem(1);
%am = ri*zj - zi*rj
element(k).am = element(k).nodei(1)*element(k).nodej(2) - element(k).nodei(2)*element(k).nodej(1);
%bm = zi - zj
element(k).bm = element(k).nodei(2)-element(k).nodej(2);
%gm = rj - ri
element(k).gm = element(k).nodej(1)-element(k).nodei(1);


%Calculate Area
element(k).a = 0.5*element(k).bj*element(k).gm;

%Calculate B matrix

element(k).B = (1/(2*element(k).a))*[element(k).bi 0 element(k).bj 0 element(k).bm 0;
               0 element(k).gi 0 element(k).gj 0 element(k).gm;
               (element(k).ai/element(k).r+element(k).bi+element(k).gi*element(k).z/element(k).r) 0 (element(k).aj/element(k).r+element(k).bj+element(k).gj*element(k).z/element(k).r) 0 (element(k).am/element(k).r +element(k).bm + element(k).gm*element(k).z/element(k).r) 0;
               element(k).gi element(k).bi element(k).gj element(k).bj element(k).gm element(k).bm;];
        
%Calculate C matrix

element(k).C  = (E/((1+v)*(1-2*v)))*[1-v v v 0;
                         v 1-v v 0;
                         v v 1-v 0;
                         0 0 0 (1-2*v)/2;];
            
%Calculate K matrix

element(k).K = 2*pi*element(k).r*element(k).a*transpose(element(k).B)*element(k).C*element(k).B;

%Calculate stresses
%must manually insert {d}
element(k).q = element(k).C*element(k).B*[0.001; 0.0002; 0.0005; 0.0006; 0; 0;];
    
end
