function [dis_mat,ang_mat] = CompuInnerDist( cont, fg_mask )
% [dis_mat,ang_mat] = CompuInnerDist( cont, fg_mask )
%		
% Compute the inner-distance matrix and inner-distance angle of an input
% shape.
% 
% Input:
% cont: input contour, should be an nx2 matrix
% fg_mask: foreground shape mask
% 
% Output:
% dis_mat: matrix of inner-distance
% ang_mat: inner-angle matrix
%
% Haibin Ling, 2/19/09
%
%%
n_pt= size(cont,1);
X	= cont(:,1);
Y	= cont(:,2);
% V	= cont;


%- the following build the graph, in that each pair of points has an edge
%between them if they can see each other inside the shape boundary
E	= build_graph_contour_C(X,Y,fg_mask,1);%bSmoothCont);
E	= E';

% disp_graph(V,E);		keyboard;

%-- the following compute the shortest path from the above graph, the
%length of the shortest path is used as the inner-distance. At the same
%time, the ang_mat shows the angles which is used as the "inner-angle" for
%building the inner-distance shape context
[dis_mat,ang_mat] = bellman_ford_ex_C(X,Y,E);
ang_mat(1:n_pt+1:end)	= 0;
