% example exs_flw1 
%----------------------------------------------------------------
% PURPOSE 
%    Analysis of one dimensional heat flow.
%----------------------------------------------------------------

% REFERENCES
%     P-E Austrell 1994-03-08 
%     K-G Olsson 1995-09-28
%     O Dahlblom 2004-09-07
%----------------------------------------------------------------
clc;
clear all;
close all;
echo on
 
%----- Topology matrix Edof -------------------------------------

Edof=[1 1 2;
      2 2 3;
      3 3 4;
      4 4 5;
      5 5 6];
 
%----- Stiffness matrix K and load vector f ---------------------

K=zeros(6); 
f=zeros(6,1);   
f(4)=10;

%----- Element properties ---------------------------------------

ep1=[25];    ep2=[24.3];
ep3=[0.4];   ep4=[17];
ep5=[7.7];
 
%----- Element stiffness matrices  ------------------------------

Ke1=spring1e(ep1);  
Ke2=spring1e(ep2);
Ke3=spring1e(ep3);  
Ke4=spring1e(ep4);
Ke5=spring1e(ep5);

%----- Assemble Ke into K ---------------------------------------

K=assem(Edof(1,:),K,Ke1);  
K=assem(Edof(2,:),K,Ke2); 
K=assem(Edof(3,:),K,Ke3);  
K=assem(Edof(4,:),K,Ke4);
K=assem(Edof(5,:),K,Ke5);
 
%----- Solve the system of equations ----------------------------

bc= [1 -25; 6 24];   
[a,r]=solveq(K,f,bc);

%----- Element flows -------------------------------------------

ed1=extract_ed(Edof(1,:),a);
ed2=extract_ed(Edof(2,:),a);
ed3=extract_ed(Edof(3,:),a);
ed4=extract_ed(Edof(4,:),a);
ed5=extract_ed(Edof(5,:),a);

q1=spring1s(ep1,ed1);
q2=spring1s(ep2,ed2);
q3=spring1s(ep3,ed3);
q4=spring1s(ep4,ed4);
q5=spring1s(ep5,ed5);

% Print results 
disp('Temperature Distribution (a):');
disp(a);

disp('Heat Flow (q):');
disp(['q1 = ', num2str(q1)]);
disp(['q2 = ', num2str(q2)]);
disp(['q3 = ', num2str(q3)]);
disp(['q4 = ', num2str(q4)]);
disp(['q5 = ', num2str(q5)]);

%---------------------------- end -------------------------------
echo off
