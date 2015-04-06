function classindices=sortclassindices(Arousal,Valence,Dominance,classes)
% Finds indices of all classes as in input classes
% returns a cell array classindices with dimension length(classes) X 2

classindices=cell(length(classes),2);
flag=1;
for i =1:length(classes)
    if strcmp(classes{i},'PLL')
        indices=find(Valence>5 & Arousal<=5 & Dominance<=5);
    elseif strcmp(classes{i},'PLH')
        indices=find(Valence>5 & Arousal<=5 & Dominance>5);
    elseif strcmp(classes{i},'PHL')
        indices=find(Valence>5 & Arousal>5 & Dominance<=5);
    elseif strcmp(classes{i},'PHH')
        indices=find(Valence>5 & Arousal>5 & Dominance>5); 
    elseif strcmp(classes{i},'NLL')
        indices=find(Valence<=5 & Arousal<=5 & Dominance<=5);
     elseif strcmp(classes{i},'NHL')
         indices=find(Valence<=5 & Arousal>5 & Dominance<=5);
     elseif strcmp(classes{i},'NLH')
         indices=find(Valence<=5 & Arousal<=5 & Dominance>5);
     elseif strcmp(classes{i},'NHH')
         indices=find(Valence<=5 & Arousal>5 & Dominance>5);
     end
    if(isempty(indices))
            continue;
    else
       classindices{flag,1}=classes{i};
       classindices{flag,2}=indices;
       flag=flag+1;
    end
    
end

classindices(flag:end,:)=[];



