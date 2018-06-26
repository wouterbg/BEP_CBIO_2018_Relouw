function [number] = createMatrix(summaryOne,summaryTwo,summaryThree)
    number = [];
    %plot one
    for i = 1:length(summaryOne)
        for j = 1:length(summaryOne{1,i})
            number(i,j) = summaryOne{1,i}{1,j}.TU_Num;
        end
    end

    %plot two
    for i = 1:length(summaryTwo)
        for j = 1:length(summaryTwo{1,i})
            number(i,length(summaryOne{1,i})+j) = summaryTwo{1,i}{1,j}.TU_Num;
        end
    end
    
    %plot three
    for i = 1:length(summaryThree)
        for j = 1:length(summaryThree{1,i})
            number(i,length(summaryOne{1,i})+length(summaryTwo{1,i})+j) = summaryThree{1,i}{1,j}.TU_Num;
        end
    end
end