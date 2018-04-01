%PROGRAM MADE BY THIAGO MACHADO AS A FINAL PROJECT FOR
%THE CIRCUITS 2 CLASS
%
%THIS FUNCTION IS BASED ON A METODOLOGY OF CIRCUIT ANALYSIS
%AND YOU GONNA NEED A PREVIEW KNOWLEGDE IN CIRCUITS ANALYSIS
%TO USE IT CORRECTILY
%
%THIS FUNTIONS IS EXPLAINED IN A SMALL .PPX PRESENTATION ANEXED
%IN THE GIT FOLDER

function [ I , V, Y, Id ,Vd ,A,Fn] = analysis( nos, malhas )

Yv=sym('Y',[1 malhas]);
Iv =sym('I',[1 malhas]);
Vv =sym('V',[1 malhas]);

%YOU HAVE 2 OPTION. IF YOU HAVE ALL THE VALUES OF THE COMPONENTS, CHOSE 1
%IF YOU WANNA WORK WITH VARIABLES, THAN YOU CHOOSE 2

fprintf('\n\n ARE YOU WORKING WITH:\n [1]VALUES OF THE COMPONENTS\n [2]VARIABLES\n ');
prompt= '\n\n ';
ANS = input(prompt);



%--------------------THIS SECTION COVERS THE NUMERIC OPERATIONS-----------------

if ANS ==1
A = zeros(nos,malhas); %INCIDENCE MATRIX
Y = zeros(malhas,malhas);%ADMITTANCE MATRIX
Vd = zeros(malhas,1); % INDEPENDENT VOLTAGE SOURCES VECTOR
Id = zeros(malhas,1); %INDEPENDENT CURRENT SOURCES VECTOR

fprintf('\n\nVLETS MAKE THE INCIDENCE MATRIX:\n\SHAPE: [OUT_NODE IN_NODE]\n');
fprintf(' REMEMBER TO USE BRAQUETS!!! Ex.:  [ 1 3 ]\n\n');

%------ INCIDENCE MATRIX BUILD-----------

for x = 1 : malhas
    fprintf ('BRANCH %d',x);
    prompt= ':\n\n ';
    temp = input(prompt);
    A(temp(1),x) = 1;
    A(temp(2),x) = -1;
    if temp(1)>nos||temp(2)>nos
        fprintf('\n\nYOUR CIRCUIT HAS %d NODES,YOU TYPED A NUMBER BIGGER THAN %d\n\n', nos,nos);
        I=0; V=0;
        return
    end
end

%--------REMOVING REFERENCE NODE-----------

A (end, :)=[];


%--------------BUILDING ADMITTANCE MATRIX---------------------

fprintf('\n\nLETS MAKE OUR ADMITTANCE MATRIX.TYPE THE -->>> IMPEDANCE <<<--, IF THERE''RE ONE.');
for i = 1:malhas    
     fprintf('\n BRANCH %d' ,i);
     prompt = ': \n\n';
     Y(i,i)= 1/input(prompt); %SAVES THE VALUES IN THE DIAGONAL MATRIX
end

%------------BUILDING OF THE INDEPENDENT CURRENT SOURCES MATRIX-----------

fprintf('\n\nINDEPENDENT CURRENT SOURCES BY BRANCH');
for i = 1:malhas    
     fprintf('\n BRANCH %d, IF THERE ARE' ,i);
     prompt = ': \n\n';
     Id(i,1)= input(prompt); %THE VALUES ARE BEING PUTTED IN THE MATRIX
end

%--------------BUILDING OF THE INDEPENDENT VOLTAGE SOURCES MATRIX----------------
fprintf('\n\nFONTES INDEPENDENTES DE TENSÃO POR RAMO');
for i = 1:malhas    
     fprintf('\nCASO EXISTA, RAMO %d' ,i);
     prompt = ': \n\n';
     Vd(i,1)= input(prompt);
end
%----------MATRIX OPERATIONS-------------

I = (A*Y)*Vd - A*Id;
Fn = (A*Y)*A';
Fn_INV = inv(Fn);
V = Fn_INV*I;




%---------------THIS SECTION COVERS THE VARIABLES OPERATIONS------

elseif ANS == 2 
A = zeros(nos,malhas); %INCIDENCE MATRIX
Y = sym(zeros(malhas,malhas));%ADMITTANCE MATRIX
Vd = sym(zeros(malhas,1)); % INDEPENDENT VOLTAGE SOURCES VECTOR
Id = sym(zeros(malhas,1)); % INDEPENDENT CURRENT SOURCES VECTOR

fprintf('\n\nVLETS MAKE THE INCIDENCE MATRIX:\n\SHAPE: [OUT_NODE IN_NODE]\n');
fprintf(' REMEMBER TO USE BRAQUETS!!! Ex.:  [ 1 3 ]\n\n');
 
   
   %---------MATRIZ INCIDENCIA-------
for x = 1 : malhas
    fprintf ('BRANCH %d',x);%TELLS THE BRANCH
    prompt= ':\n\n ';
    temp = input(prompt);%RECEIVES THE VALUE
    A(temp(1),x) = 1;%SETS 1 TO THE OUT NODE
    A(temp(2),x) = -1;%SETS -1 TO THE IN NODE
    
    if temp(1)>nos||temp(2)>nos %IN CASE THE USER TYPE A INVALID NUMBER, SENDS THE MESSAGE BELLOW
        fprintf('\n\nYOUR CIRCUIT HAS %d NODES,YOU TYPED A NUMBER BIGGER THAN %d\n\n', nos,nos);
        I=0; V=0;
        return
    end
end
%--------REMOVING REFERENCE NODE------------
A (end, :)=[];

%--------BUILDIN OF THE ADMITTANCE MATRIX WITH VARIABLES--------

    for i = 1:malhas
        Y(i,i) = Yv(i);
    end
  
    %----------CURRENT SOURCE-------
    fprintf('\n\nINDEPENDENT CURRENT SOURCES BY BRANCH\nTYPE 1-YES, ZERO-NO\n\n ');
for i = 1:malhas    
     fprintf('BRANCH %d' ,i);%YOU NEED TO TYPE IN THE CORRECT SEQUENCE BY BRANCH
     prompt = ': \n\n';
     var=input(prompt);
     if var==1||var==-1
     Id(i,1)= var*Iv(i);
     
     else Id(i,1)= 0;
     end
end

%------------VOLTAGE SOURCE------------

fprintf('\n\nINDEPENDENT VOLTAGE SOURCES BY BRANCH,\n\nIF THERE ARE ONE,TYPE 1-YES, ZERO-NO\n\n ');
for i = 1:malhas    
     fprintf('BRANCH %d' ,i);
     prompt = ': \n\n';
     
     var = input(prompt);
     if var==1||var==-1
     Vd(i,1)=var* Vv(i);
     
     else Vd(i,1)= 0;
     end
end

%-----------MATRIX OPERATIONS-----------
I = (A*Y)*Vd - A*Id;
Fn = (A*Y)*A';
Fn_INV = inv(Fn);
V = Fn_INV*I;

end


    
end


