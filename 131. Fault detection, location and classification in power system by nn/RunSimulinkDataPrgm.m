clc
clear all

% Distance in fromt of fault
L_range = [1, 3, 5, 7, 9, 10, 12, 15, 16, 18, 20, 23, 25, 28, 30];

% Distance behind fault
W_range = [10, 20, 13, 30, 12, 2, 7, 24, 3, 18, 28, 12, 10, 1, 6];
x = cell(1, length(L_range));
t = cell(1, length(L_range));

% Iterate through each length of fault
for j = 1:length(L_range)
    %L = the length of the fault from controller
    L = L_range(j);
    %W = the length of the fault from other generator
    W = W_range(j);
    
    %run through each of the simulations
    simopt = simset('solver','ode23tb','SrcWorkspace','Current','DstWorkspace','Current');  % Initialize sim options
    [tout,xout,yout] = sim('LineFaultModel1',[0 0.4],simopt);
    x1=[va vb vc ia ib ic v0 i0];
    t1=[0 0 0 0 L];
    [tout,xout,yout] = sim('LineFaultModel1ag',[0 0.4],simopt);
    x2=[va vb vc ia ib ic v0 i0];
    t2=[1 0 0 1 L];
    [tout,xout,yout] = sim('LineFaultModel1bg',[0 0.4],simopt);
    x3=[va vb vc ia ib ic v0 i0]
    t3=[0 1 0 1 L];
    [tout,xout,yout] = sim('LineFaultModel1cg',[0 0.4],simopt);
    x4=[va vb vc ia ib ic v0 i0];
    t4=[0 0 1 1 L];
    [tout,xout,yout] = sim('LineFaultModel1abg',[0 0.4],simopt);
    x5=[va vb vc ia ib ic v0 i0];
    t5=[1 1 0 1 L];
    [tout,xout,yout] = sim('LineFaultModel1acg',[0 0.4],simopt);
    x6=[va vb vc ia ib ic v0 i0];
    t6=[1 0 1 1 L];
    [tout,xout,yout] = sim('LineFaultModel1bcg',[0 0.4],simopt);
    x7=[va vb vc ia ib ic v0 i0];
    t7=[0 1 1 1 L];
    [tout,xout,yout] = sim('LineFaultModel1abcg',[0 0.4],simopt);
    x8=[va vb vc ia ib ic v0 i0];
    t8=[1 1 1 1 L];
    [tout,xout,yout] = sim('LineFaultModel1abc',[0 0.4],simopt);
    x9=[va vb vc ia ib ic v0 i0]
    t9=[1 1 1 0 L];
    [tout,xout,yout] = sim('LineFaultModel1ab',[0 0.4],simopt);
    x10=[va vb vc ia ib ic v0 i0];
    t10=[1 1 0 0 L];
    [tout,xout,yout] = sim('LineFaultModel1ac',[0 0.4],simopt);
    x11=[va vb vc ia ib ic v0 i0];
    t11=[1 0 1 0 L];
    [tout,xout,yout] = sim('LineFaultModel1bc',[0 0.4],simopt);
    x12=[va vb vc ia ib ic v0 i0];
    t12=[0 1 1 0 L];

    % Concatenate x1 and x2 vertically to form a single row
    x{j} = [x1;x2; x3; x4; x5; x6; x7; x8; x9; x10; x11; x12;];
    t{j} = [t1;t2; t3; t4; t5; t6; t7; t8; t9; t10; t11; t12;];
end

% Concatenate the xdata and tdata for all fault lengths vertically to form Xdata and Tdata respectively
Xdata_to_DNN = vertcat(x{:});
Tdata_to_DNN = vertcat(t{:});

writematrix(Xdata_to_DNN,'Xdata_to_DNN.csv');
writematrix(Tdata_to_DNN,'Tdata_to_DNN.csv');

nftool
