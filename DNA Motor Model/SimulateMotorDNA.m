function [t, p] = SimulateMotorDNA(n, ne, brownianFrequency, density, nSpan)
    %% Simulation Parameters
    N = 1e4; % size of RNA array (surface)
    Kon = 1; % s^-1
    Koff = 3; % s^-1
    Kcat = 3;  % s^-1
    timeStep = 0.01; % s, resolution
    tMax = 600; % s, total time simulated

    DNA = ones(n,n); % 0 = unbound, 1 = bound, 2 = gone
    RNA = zeros(N,N); % 0 = unbound, 1 = bound, 2 = gone
    enzymes = zeros(1,ne); % 0 = unbound, 1 = bound
    bindingProbabilities = ones(n,n);
    adjustProb = 1;
    inProgress = -1 * ones(n,n,2); % layer 1 is action in progress (-1 = nothing, 0 = unbinding, 1 = binding, 2 = cutting), layer 2 is time left
    
%     temp
%     bindingProbabilities([1 end],:) = 1e3;
%     bindingProbabilities(:,[1 end]) = 1e3;

    % remove DNA based on density and nSpan
    num_to_remove_density = (nSpan * nSpan) - round(nSpan * nSpan * density);
    num_to_remove_span = (n * n) - (nSpan * nSpan);
    num_to_remove = num_to_remove_density + num_to_remove_span;
    missing_ind = randsample(n * n, num_to_remove);
    DNA(missing_ind) = 2;

    % initial conditions
    currentPosition = [N/2, N/2]; %position of DNA particle, start in the middle of the field
    subRNA = ones(n,n); % initially bound, store matching RNA field with DNA size each loop
    RNA(currentPosition(1):currentPosition(1)+n-1, currentPosition(2):currentPosition(2)+n-1) = subRNA; %initialize
    currentTime = 0; % s
    t = []; % time array
    p = []; % position array

    % add white noise to integer position from brownian motion
    tic
    %% Main Simulation
    while currentTime < tMax
        %current_time

        % record time and position
        t = [t; currentTime];
        p = [p; currentPosition];

        % line up DNA and RNA array
        subRNA = RNA(currentPosition(2):currentPosition(2)+n-1, currentPosition(1):currentPosition(1)+n-1); 

        % loop through all positions in both RNA and DNA arrays
        for i = 1:n
            for j = 1:n

                if (inProgress(i,j,1)>-1) % if no action in progress
                    % then continue action in progress
                    if (inProgress(i,j,2) - timeStep <= 0) % take the action and reset
                        if (inProgress(i,j,1)==0)
                            DNA(i,j) = 0; %unbind DNA
                            subRNA(i,j) = 0; %unbind RNA
                            inProgress(i,j,1) = -1; %reset 
                        elseif (inProgress(i,j,1)==1)
                            DNA(i,j) = 1; %bind DNA
                            subRNA(i,j) = 1; %bind RNA
                            inProgress(i,j,1) = -1; %reset 
                        elseif (inProgress(i,j,1)==2)
                            DNA(i,j) = 0; %unbind DNA
                            subRNA(i,j) = 2; %cleave RNA
                            boundEnzyme = find(enzymes==1, 1, 'first'); %find bound enzyme
                            enzymes(boundEnzyme) = 0; %unbind enzyme
                            inProgress(i,j,1) = -1; %reset 
                        end
                    else % subtract this time
                        inProgress(i,j,2) = inProgress(i,j,2) - timeStep;
                    end


                elseif (DNA(i,j)==0 && subRNA(i,j)==0) % if both unbound
                    % then handle potential binding
                    inProgress(i,j,1) = 1; % binding in progress
                    inProgress(i,j,2) = exprnd(1/Kon); % time it will take


                elseif (DNA(i,j)==1 && subRNA(i,j)==1) % if both  bound
                    % then handle potential enzyme interaction
                    t_to_finish_cutting = exprnd(1/Kcat);
                    t_to_unbind = exprnd(1/Koff);

                    if (t_to_unbind < t_to_finish_cutting) % if time to unbind is faster
                        inProgress(i,j,1) = 0; % unbinding in progress
                        inProgress(i,j,2) = t_to_unbind; % time it will take
                    else % search through all available enzymes
                        for ie = 1:ne
                            if (enzymes(ie)==0 && rand<adjustProb*bindingProbabilities(i,j)/sum(sum(bindingProbabilities)))
                                enzymes(ie) = 1; % bind enzyme
                                inProgress(i,j,1) = 2;
                                inProgress(i,j,2) = t_to_finish_cutting;
                                break % break loop if enzyme binds
                            end
                        end
                    end % if no enzyme is found, then do nothing. we will land on this loop again next time step.


                elseif (subRNA(i,j)==2 || DNA(i,j)==2) % if RNA or DNA gone
                    % then do nothing
                end


            end
        end
        
        
        % change missing DNA from 2's to 0's temoprarily
        DNA(missing_ind) = 0;

        % check for particle lifting
        if (sum(sum(DNA))==0 && currentTime > 10*timeStep)
            break
        end

        % put subRNA information back into main RNA array
        RNA(currentPosition(2):currentPosition(2)+n-1, currentPosition(1):currentPosition(1)+n-1) = subRNA;

        % update time
        currentTime = currentTime + timeStep;
        
        % update position, DNA array, and in progress array
        moveProbability = brownianFrequency * timeStep; % probability that we will move
        if (rand < moveProbability)
            [currentPosition, DNA, inProgress, missing_ind] = UpdateParticlePosition(currentPosition, DNA, inProgress, missing_ind);
        end
      
    end
    

end


%% Update Particle Position
function [currentPosition, DNA, inProgress, missing_ind] = UpdateParticlePosition(currentPosition, DNA, inProgress, missing_ind)

    % update particle position and DNA array if possible (check 4 edges)
    n = sqrt(numel(DNA));
    emptyTop = 0;
    for i = 1:(n/2)
        if (sum(DNA(i,:))==0), emptyTop = emptyTop + 1; else, break, end
    end
    emptyBot = 0;
    for i = n:-1:(n/2)+1
        if (sum(DNA(i,:))==0), emptyBot = emptyBot + 1; else, break, end
    end
    emptyLeft = 0;
    for i = 1:(n/2)
        if (sum(DNA(:,i))==0), emptyLeft = emptyLeft + 1; else, break, end
    end
    emptyRight = 0;
    for i = n:-1:(n/2)+1
        if (sum(DNA(:,i))==0), emptyRight = emptyRight + 1; else, break, end
    end
    
    
    % create array of possible movement numbers for vertical and horizontal
    verticalMove = -emptyTop:emptyBot;
    horizontalMove = -emptyRight:emptyLeft;
    move = [horizontalMove(randperm(numel(horizontalMove),1)), verticalMove(randperm(numel(verticalMove),1))];
    
    % change missing indicies back to 2, so when we rotate the particle, we
    % keep an equal number of missing indicies
    DNA(missing_ind) = 2;
    
    % move edges in DNA and inProgress according to the move vector
    % horizontal movement
    if (move(1) > 0) % move left columns to right
        DNA = [DNA(:,move(1)+1:end) DNA(:,1:move(1))]; 
        inProgress = [inProgress(:,move(1)+1:end,:) inProgress(:,1:move(1),:)]; 
    elseif (move(1) < 0) % move right columns to left
        DNA = [DNA(:,end:-1:n+move(1)+1) DNA(:,1:end+move(1))];
        inProgress = [inProgress(:,end:-1:n+move(1)+1,:) inProgress(:,1:end+move(1),:)];
    end
    % vertical movement
    if (move(2) > 0) % move bottom row to top
        DNA = [DNA(end:-1:n-move(2)+1,:); DNA(1:end-move(2),:)];
        inProgress = [inProgress(end:-1:n-move(2)+1,:,:); inProgress(1:end-move(2),:,:)];
    elseif (move(2) < 0) % move top row to bottom
        DNA = [DNA(-move(2)+1:end,:); DNA(1:-move(2),:)];
        inProgress = [inProgress(-move(2)+1:end,:,:); inProgress(1:-move(2),:,:)];
    end
    
    
    %update the missing indicies
    missing_ind = find(DNA==2);
    
    
    % update position
    currentPosition = [currentPosition(1) + move(1), currentPosition(2) - move(2)];

end