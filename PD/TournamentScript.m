%% Player definitions: This is the only part you need to modify to add your bot
defPlayersHandles={@BotNice,@BotNasty,@BotR1,@BotR2,@BotTTN,@BotTT};
defPlayersNames={'Bot Nice','Bot Nasty','Bot Random 1','Bot Random 2','Bot Smart 1', 'Bot Smart 2'};


%% Initialize RNG
rng('shuffle');

%% Game Definition
ValueScore=[2 1 -2 -1]; %value of victory, cooperation, defeat or non-cooperation
ResultMat=[ValueScore(4) ValueScore(1);ValueScore(3) ValueScore(2)];
noise=0.01;

%% Number of players
assert( (numel(defPlayersHandles)==numel(defPlayersNames)) );
Nplayers=numel(defPlayersHandles);

%% Randomly permute the players so their ID is random
IDplayers=randperm(Nplayers);
PlayersHandles=defPlayersHandles(IDplayers);
PlayersNames=defPlayersNames(IDplayers);

%% Tournament

Npair=randi([450 550],1); % Randomized so end is not predictable by the players
Ngames=Nplayers*(Nplayers-1)/2*Npair;
orderedgames=[];

for i=1:Nplayers
  for j=i+1:Nplayers
    toadd=zeros(Npair,2);
    for k=1:Npair
      if rand(1)<0.5
        toadd(k,:)=[i j];
      else
        toadd(k,:)=[j i];
      end
    end
    orderedgames=[orderedgames;toadd];
  end
end

% We randomly permute the games 
pp=randperm(Ngames);
allgames=orderedgames(pp,:);

History=[0,0,0,0,0];
PlayersTotScores=nan(Ngames,Nplayers);
PlayersHistoScores=zeros(4,Nplayers);
PlayerPlayedGame=zeros(Nplayers,1);
LastScoresHist=zeros(Ngames,Nplayers);

%% Master Loop
for Game=1:Ngames
    Opponents=allgames(Game,:);
    OpponentAID=Opponents(1);
    OpponentBID=Opponents(2);
    
    AwasPresent=(History(:,2)==OpponentAID | History(:,3)==OpponentAID);
    if any(AwasPresent)
        Ahist=History(AwasPresent,:);
    else
        Ahist=[];
    end
    OpponentAChoice=PlayersHandles{OpponentAID}(OpponentAID,OpponentBID,Ahist,Game,ResultMat);%Hide other game history
    if rand(1)<noise
      OpponentAChoice=1-OpponentAChoice;
    end
    
    BwasPresent=(History(:,2)==OpponentBID | History(:,3)==OpponentBID);
    if any(BwasPresent)
        Bhist=History(BwasPresent,:);
    else
        Bhist=[];
    end
    OpponentBChoice=PlayersHandles{OpponentBID}(OpponentBID,OpponentAID,Bhist,Game,ResultMat);
    if rand(1)<noise
      OpponentBChoice=1-OpponentBChoice;
    end
    
    ResultA=ResultMat(OpponentAChoice+1,OpponentBChoice+1);
    ResultB=ResultMat(OpponentBChoice+1,OpponentAChoice+1);
    
    
    PlayerPlayedGame([OpponentAID,OpponentBID ])=PlayerPlayedGame([OpponentAID,OpponentBID ])+1;
    
    PlayersTotScores(Game,[OpponentAID OpponentBID])=[ResultA ResultB] ;
    
    
    addvac=[1 1 1 1]*ResultA;
    addvac=addvac==ValueScore;
    PlayersHistoScores(addvac,OpponentAID)=PlayersHistoScores(addvac,OpponentAID)+1;
    
    addvac=[1 1 1 1]*ResultB;
    addvac=addvac==ValueScore;
    PlayersHistoScores(addvac,OpponentBID)=PlayersHistoScores(addvac,OpponentBID)+1;
    
    History(Game,:)=[Game,OpponentAID,OpponentBID,OpponentAChoice,OpponentBChoice];
    
    
    Normalisation=repmat(PlayerPlayedGame',4,1);
    Normalisation(isnan(Normalisation))=1;
    LastScores=sum(repmat(ValueScore',1,Nplayers).*PlayersHistoScores);
    LastScoresHist(Game,:)=LastScores;
end


%% Plotting results

colorcodes={'r','b','k','g','m','c','y',[0.5 0.5 0.5],[0.5 0.5 0.8],[0.5 0.8 0.5],[0.8 0.5 0.5]};

% Figure 1 : distribution of payoffs
hPlayerScoresHist=figure;
hArray =bar(ValueScore,PlayersHistoScores./Normalisation);
for player=1:Nplayers
    set(hArray(player),'FaceColor',colorcodes{player});
end
legend(PlayersNames,'Location','NorthWest');
ylabel('Proportion','FontSize',14);
set(gca,'XTick',[-2 -1 1 2]);
set(gca,'XTickLabel',{'CvsD','DvsD','CvsC','DvsC'});
set(gca,'FontSize',14);

% Figure 2 : score of each player
GameResults=figure;
hbis=plot(1:Ngames,LastScoresHist,'LineWidth',3);
for player=1:Nplayers
    set(hbis(player),'Color',colorcodes{player});
end
xlim([1,Ngames]);
legend(PlayersNames,'Location','NorthWest');
ylabel('Commulated Scores','FontSize',14);
xlabel('Time','FontSize',14);
set(gca,'FontSize',14);


%% Textual output
% Score du joueur
for i=1:Nplayers
  fprintf('%s : score %d, rank: %d\n',PlayersNames{i},LastScores(i),find(sort(LastScores,'descend')==LastScores(i)));
end