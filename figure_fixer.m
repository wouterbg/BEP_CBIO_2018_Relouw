clear, close all
dir = 'C:\Users\s167917\Documents\#School\Jaar 3\2 OGO Computational Biology\BEP_model\output\test_4';
cd(dir)
all_stuff = string(ls);
all_stuff = all_stuff(isfolder(all_stuff));
all_stuff = all_stuff(3:end);
order = all_stuff;
images = cell(length(all_stuff),3);
for i = 1:length(order)    
    idx = find(order{i}=='_');
    order{i} = order{i}(idx(2)+1:end);
end

for i = 1:length(all_stuff)
    cd(strcat(dir,"\",all_stuff{i}))
    files = string(ls);       

    one = 0;
    two = 0;
    three = 0;
    for j = 1:length(files)           
        if contains(files{j},"ONE")
            one = j;
        elseif contains(files{j},"TWO")
            two = j;
        elseif contains(files{j},"THREE")
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

[sorted_names,idx] = sort(order);
images = images(idx,:);
margin = 3;
height = size(images{1,1},1);
width = size(images{1,1},2);
nr_x = 3;
nr_y = 3;
names = strings(nr_y,nr_x);
full_one = zeros(height*nr_y+margin*(nr_y-1),width*nr_x+margin*(nr_x-1),3);
full_two = full_one;
full_three = full_one;

index = 0;
x = 1;
for xi = 1:nr_x
    y = 1;    
    for yi = 1:nr_y
        index = index+1;
        names(yi,xi) = sorted_names(index);
        full_one(y:y+height-1,x:x+width-1,:)=images{index,1};
        full_two(y:y+height-1,x:x+width-1,:)=images{index,2};
        full_three(y:y+height-1,x:x+width-1,:)=images{index,3};
        y = y+height+margin;       
    end
    x = x+width+margin;
end
disp(names)
figure, imshow([full_two,zeros(size(full_two,1),margin*3,3),full_three])
imwrite(full_one,char(strcat(dir,"\1_tumor_growth.png")))
imwrite(full_two,char(strcat(dir,"\2_differentation.png")))
imwrite(full_three,char(strcat(dir,"\3_immuno_therapy.png")))