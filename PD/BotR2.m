function decision=BotR2(MyID,Idopponent,GameHistory,IdFight,ResultMat)
%% Decision is coded accordingly : 1 = cooperation, 0 = non cooperation.
% GameHistory is coded accordingly : GameHistory(j,:)=[IdFight, opponent a,
% opponend b, decision a, decision b]; for jth fight.
% ResultMat :This variable gives you the score associated with two players'
% decisions. ResultMat(decision_a+1,decision_b+1) gives you the score FOR PLAYER A, 
%ResultMat(decision_b+1,decision_a+1) gives you the score FOR PLAYER B.


%This is a random player with a greedy strategy : it cooperates 40% of time
%only
decision=rand(1)>0.6;


end