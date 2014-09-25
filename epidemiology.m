function [ nbinfected,nbimmunized ] = epidemiology( nbstudents, pinf, pcur, nini )
%EPIDEMIOLOGY Run one simulation of evolution of the disease.
%   nbstudents is total number of students in the class.
%   pinf is probability of infection when one infected student hooks up
%   with one succeptible student.
%   pcur is probability for one infected student of becoming disease free
%   (and immunized) each week.
%   nini is the initial number of infected students.

nstep=100;

nbinfected=zeros(nstep,1);
nbsucceptible=zeros(nstep,1);
% We keep track of number of infected and number of succeptible students.
% Students that are neither infected neither succeptible are immunized.

nbinfected(1)=nini;
nbsucceptible(1)=nbstudents-nbinfected(1);

for t = 2:100
    % We first simulate recovery
    nbinfected(t)=nbinfected(t-1)-numel(find(rand(nbinfected(t-1),1)<pcur));
    nbsucceptible(t)=nbsucceptible(t-1);
    
    % We randomly separate students into infected, succeptible (and
    % immunized)
    allstudents=randperm(nbstudents);
    infectedstudents=allstudents(1:nbinfected(t));%randsample(nbstudents,nbinfected(t));
    succeptiblestudents=allstudents(nbinfected(t)+1:nbinfected(t)+nbsucceptible(t));
    
    % We draw a list of twenty couples
    couples=randsample(nbstudents,40/50*nbstudents);
    for i=1:20/50*nbstudents
        stu1=couples(i);
        stu2=couples(20/50*nbstudents+i);
        if (any(infectedstudents==stu1) && any(succeptiblestudents==stu2)) || (any(infectedstudents==stu2) && any(succeptiblestudents==stu1)) % If one student is infected and the other is succeptible:
            if rand(1,1)<pinf
                nbinfected(t)=nbinfected(t)+1; % The succeptible student becomes infected
                nbsucceptible(t)=nbsucceptible(t)-1;
            end
        end
    end 
end

nbimmunized=nbstudents-nbinfected-nbsucceptible;
end

