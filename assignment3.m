clc;clear;
a = load("irisdata.mat");
K = 150;       % number of clusters wanted 
iterations = 1000;  %number of times you want k-means to run
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
count1 = 0;  %these hold the number of data points in each centroid
count2 = 0;
count3 = 0;
for i=1:150
  
      if cluster_assignments(i,1) == 1
         count1 = count1 + 1;
      end
       if cluster_assignments(i,1) == 2
         count2 = count2 + 1;
       end
       if cluster_assignments(i,1) == 3
         count3 = count3 + 1;
      end
  
end
cluster1(1:count1,1:2) = 0; %these will hold all the datapoints that belong in each cluster format( id, distance)
cluster2(1:count2,1:2) = 0;
cluster3(1:count3,1:2) = 0;

for j = 1:count1
   index = 1;
   x = 1;
   for i = x:150
    if cluster_assignments(i,1) == 1
       x = i;
       cluster1(index,1) = i;
       cluster1(index,2) = cluster_assignments(i,2);
       index = index + 1;
    end
   end
    
end
for j = 1:count2
   index = 1;
   x = 1;
   for i = x:150
    if cluster_assignments(i,1) == 2
       x = i;
       cluster2(index,1) = i;
       cluster2(index,2) = cluster_assignments(i,2);
       index = index + 1;
    end
   end
    
end
for j = 1:count3
   index = 1;
   x = 1;
   for i = x:150
    if cluster_assignments(i,1) == 3
       x = i;
       cluster3(index,1) = i;
       cluster3(index,2) = cluster_assignments(i,2);
       index = index + 1;
    end
   end
    
end
topcluster1(1:3,1) = 0; %will store the top 3 datapoints of each cluster
topcluster2(1:3,1) = 0;
topcluster3(1:3,1) = 0;  
for i =1:3              %we will loop to find the top 3 datapoints that are closest to the centroid
   [M, index] = min(cluster1(:,2));
   topcluster1(i,1) = cluster1(index,1);
   cluster1(index,2) = 100; 
end
for i =1:3
   [M, index] = min(cluster2(:,2));
   topcluster2(i,1) = cluster2(index,1);
   cluster2(index,2) = 100; 
end
for i =1:3
   [M, index] = min(cluster3(:,2));
   topcluster3(i,1) = cluster3(index,1);
   cluster3(index,2) = 100; 
end