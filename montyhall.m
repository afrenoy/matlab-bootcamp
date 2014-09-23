%% Initialization
n=10000;

doorcar=randi(3,1,n);
doorplayer=randi(3,1,n);

win1=zeros(1,n);
win2=zeros(1,n);

%% Do many simulations
for i=1:n
  
  %% Presenter hides the car
  c=doorcar(i);
  
  %% Player chooses a door
  p=doorplayer(i);
  
  %% Presenter randomly chooses a door with a goat
  if (c==p) % Player choosed the car
    d=1:3; % Vector with all possible doors
    presenterchoices=find(d~=c); % Presenter has two possibles doors to open 
    presentershows=presenterchoices(randi(2,1,1)); % He randomly chooses one
  else % Player choosed a goat
    d=1:3; % Vector with all possible doors
    presentershows=find(d~=c & d~=p); % Presenter shows the door wich is not choosed by the player and not a car
  end
  
  %% Two different strategies
  p1=p; % Player 1 does not change
  p2=find(d~=p & d~=presentershows); % Player 2 does change : he chooses the "other" door (not its first choice and not opened by the presenter)

  win1(i)=(p1==c);
  win2(i)=(p2==c);
end

%% Display results
rate1=sum(win1)/n;
rate2=sum(win2)/n;
bar([1,2],[rate1,rate2]);
xlim([0.4 2.6]);
set(gca,'XTick',[1 2]);
set(gca,'XTickLabel',{'Do not change','Change'});
set(gca,'FontSize',16);
ylabel('Probability of win','FontSize',16
