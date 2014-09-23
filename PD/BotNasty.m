function decision=BotNasty(MyID,Idopponent,GameHistory,IdFight,ResultMat)
% GameHistory is coded accordingly : GameHistory(j,:)=[IdFight, opponent a,
% opponend b, decision a, decision b]; for jth fight.
% ResultMat :This variable gives you the score associated with two players'
% decisions. ResultMat(decision_a+1,decision_b+1) gives you the score FOR PLAYER A, 
%ResultMat(decision_b+1,decision_a+1) gives you the score FOR PLAYER B.


%This is a very nasty player. It never collaborate
decision=0;

end