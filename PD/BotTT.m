function decision=BotTT(MyID,Idopponent,GameHistory,IdFight,ResultMat)
%% Decision is coded accordingly : 1 = cooperation, 0 = non cooperation.
% GameHistory is coded accordingly : GameHistory(j,:)=[IdFight, opponent a,
% opponend b, decision a, decision b]; for jth fight.
% ResultMat :This variable gives you the score associated with two players'
% decisions. ResultMat(decision_a+1,decision_b+1) gives you the score FOR PLAYER A, 
%ResultMat(decision_b+1,decision_a+1) gives you the score FOR PLAYER B.


PlayDefaultStrategy=false; %flag to decide whether apply default strategy


if size(GameHistory,1)>0 %there is some history
% Compute strategy

AllPlayerIds=GameHistory(:,2:3);
[PastFightId,isAorB]=find(AllPlayerIds==Idopponent);
if isempty(PastFightId) %first time I met this opponent
    PlayDefaultStrategy=true;
else
    [LastFightId,Index]=max(PastFightId);
    LastFightWithOpponentDecisionOpp=GameHistory(LastFightId,isAorB(Index)+3);
    LastFightWithOpponentDecisionMe=GameHistory(LastFightId,setdiff(1:2,isAorB(Index))+3);
    decisionMat=[0 1 ;0 1];%If both didn't cooperated, don't coop again
    decision=decisionMat(LastFightWithOpponentDecisionMe+1,LastFightWithOpponentDecisionOpp+1);
       
end

else %DEFAULT STRATEGY
PlayDefaultStrategy=true;
end

if PlayDefaultStrategy
    decision=1;
end


end