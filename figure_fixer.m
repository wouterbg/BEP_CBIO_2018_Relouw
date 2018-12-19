clear, close all  
dir = 'C:\Users\s167917\Documents\#School\Jaar 3\2 OGO Computational Biology\BEP_model\output\test_3';
cd(dir)
all_stuff = string(ls);
order = all_stuff;
images = cell(length(all_stuff)-2,3);
for i = 3:length(order)
    order{i} = order{i}(15:end);
end
        
for i = 1:length(all_stuff)-2
    if ~contains(all_stuff{i+2},".m")
        cd(strcat(dir,"\",all_stuff{i+2}))
        files = string(ls);       
        
        one = 0;
        two = 0;
        three = 0;
        for j = 1:length(files)-2           
            if contains(files{j+2},"ONE")
                one = j;
            elseif contains(files{j+2},"TWO")
                two = j;
            elseif contains(files{j+2},"THREE")
                three= j;
            end
        end
        if one>0
            img_one = imread(files{one});
            img_two = imread(files{two});
            img_three = imread(files{three});
            images{i,1} = img_one(:,337:1200,:);
            images{i,2} = img_two(:,337:1200,:);
            images{i,3} = img_three(:,337:1200,:);
        end 
    end
end
[~,idx] = sort(order(3:end));
images = images(idx,:);
margin = 3;
height = size(images{1,1},1);
width = size(images{1,1},2);
nr_x = 3;
nr_y = 3;
full_one = zeros(height*nr_y+margin*(nr_y-1),width*nr_x+margin*(nr_x-1),3);
full_two = full_one;
full_three = full_one;

index = 0;
x = 1;
for xi = 1:nr_x
    y = 1;    
    for yi = 1:nr_y
        index = index+1;
        full_one(y:y+height-1,x:x+width-1,:)=images{index,1};
        full_two(y:y+height-1,x:x+width-1,:)=images{index,2};
        full_three(y:y+height-1,x:x+width-1,:)=images{index,3};
        y = y+height+margin;       
    end
    x = x+width+margin;
end
imshow(full_one)
figure,imshow(full_two)
figure,imshow(full_three)
% saveas(full_one,strcat(dir,"tumor_growth"),'png')
% saveas(full_two,strcat(dir,"differentation"),'png')
% saveas(full_three,strcat(dir,"immunotherapy"),'png')



