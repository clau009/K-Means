clc;clear;
a = load("irisdata.mat");
K = 10;       % number of clusters wanted 
iterations = 1;  %number of times you want k-means to run
x_input(1:150,1:4) = a.irisdata(1:150,1:4);
init_centroids(1:K,1:4) = 0;
cluster_assignments(1:150,2) = 0;
cluster_centroids(1:K,1:4) = 0;
distances(1:K,1)=0;
r = randperm(150,K);   %picks a random integer between 1-150 
featureone = 0; %will be the total of feature 1 that will be divided by number of values to find mean
featuretwo = 0; %will be the total of feature 2 that will be divided by number of values to find mean
featurethree = 0; %will be the total of feature 3 that will be divided by number of values to find mean
featurefour = 0; %will be the total of feature 4 that will be divided by number of values to find mean
count = 0; %number of values to divide total from to find mean
sse = 0;
init_centroids = x_input(r,:);  % randomly select different initial centroids

cluster_centroids(1:K,1:4) = init_centroids(1:K,1:4);
for h=1:iterations
    for i=1:150
    
        for j=1:K           
            distances(j,1) = (abs(cluster_centroids(j,1) - x_input(i,1)).^2 + abs(cluster_centroids(j,2) - x_input(i,2)).^2 + abs(cluster_centroids(j,3) - x_input(i,3)).^2 + abs(cluster_centroids(j,4) - x_input(i,4)).^2).^(1/2);
        
        end
       [cluster_assignments(i,2),cluster_assignments(i,1)] = min(distances);     
    
    end
    
    for w=1:K  %for each cluster, find the new mean
       for z=1:150
           if cluster_assignments(z,1) == w
               featureone = featureone + x_input(z,1);
               featuretwo = featuretwo + x_input(z,2);
               featurethree = featurethree + x_input(z,3);
               featurefour = featurefour + x_input(z,4);
               count = count+1;
           end
       end
       cluster_centroids(w,1) = featureone / count;
       cluster_centroids(w,2) = featuretwo / count;
       cluster_centroids(w,3) = featurethree / count;
       cluster_centroids(w,4) = featurefour / count;
       featureone = 0;
       featuretwo = 0;
       featurethree = 0;
       featurefour = 0;
       count = 0;
    end
    
end

for i=1:150
   for j=1:K
      if cluster_assignments(i,1) == j
         sse = sse + (x_input(i,1)- cluster_centroids(j,1)).^2 + (x_input(i,2)- cluster_centroids(j,2)).^2 + (x_input(i,3)- cluster_centroids(j,3)).^2 + (x_input(i,4)- cluster_centroids(j,4)).^2;
          
      end
   end
end
