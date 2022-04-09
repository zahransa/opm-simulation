
%% parameters
distToKeepX=0.02;
distToKeepY = 0.02;
distToKeepZ = 0.02;

%% calculate distance to move

scalpWidthY = max(scalpp(:, 2)) - min(scalpp(:, 2));
sensorWidthY = max(meanLoc(:, 2)) - min(meanLoc(:, 2));
moveDistanceY = (sensorWidthY - scalpWidthY)/2 - distToKeepY;
moveDistanceZ = max(meanLoc(:, 3)) - max(scalpp(:, 3)) - distToKeepZ;
moveDistanceX = - min(meanLoc(:, 1))+ min(scalpp(:, 1)) - distToKeepX;

%% move sensors

chmeg2 = chmeg;
for indChannel = 1 : length(chmeg.Channel)
   % chmeg2.Channel(indChannel).Loc([2, 3],:) = chmeg.Channel(indChannel).Loc([2, 3],:) - [moveDistanceY; moveDistanceZ]*[1 1 1 1];
   chmeg2.Channel(indChannel).Loc = chmeg.Channel(indChannel).Loc - [-moveDistanceX; moveDistanceY; moveDistanceZ]*[1 1 1 1];
end