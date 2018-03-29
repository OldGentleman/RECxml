clc,clear
close all
filepath = 'xml-original/';
imgpath = 'Images/';
dirname = dir(filepath);
dirname = dirname(3:end);
gtids = {dirname.name};
for i=1:length(gtids)
    xmlpath = strcat(filepath,gtids{i});
    xmlcontent = VOCreadxml(xmlpath);
    xmlfolder = xmlcontent.annotation.folder;
    xmlfilename = xmlcontent.annotation.filename;
    xmlpath = xmlcontent.annotation.path;
    xmlsize = xmlcontent.annotation.size;
    xmlobject = xmlcontent.annotation.object; % 需要
    
    %读取图片
%     picpath = strcat(imgpath,xmlfilename);
%     pic = imread(picpath);
%     h=figure,
%     imshow(pic)
%     hold on
    for j = 1 : length(xmlobject)% 一个xml中的每个标签
        x1 = str2num(xmlobject(j).polygon.x1);
        y1 = str2num(xmlobject(j).polygon.y1);
        x2 = str2num(xmlobject(j).polygon.x2);
        y2 = str2num(xmlobject(j).polygon.y2);
        x3 = str2num(xmlobject(j).polygon.x3);
        y3 = str2num(xmlobject(j).polygon.y3);
        x4 = str2num(xmlobject(j).polygon.x4);
        y4 = str2num(xmlobject(j).polygon.y4);
        
        %处理变矩形:
        changebox = incline_turth_box([x1,x2,x3,x4;y1,y2,y3,y4]);
        
        %处理结束
        xmlcontent.annotation.object(j).polygon.x1 = num2str(int32(changebox(1)));
        xmlcontent.annotation.object(j).polygon.y1 = num2str(int32(changebox(2)));
        xmlcontent.annotation.object(j).polygon.x2 = num2str(int32(changebox(3)));
        xmlcontent.annotation.object(j).polygon.y2 = num2str(int32(changebox(4)));
        xmlcontent.annotation.object(j).polygon.x3 = num2str(int32(changebox(5)));
        xmlcontent.annotation.object(j).polygon.y3 = num2str(int32(changebox(6)));
        xmlcontent.annotation.object(j).polygon.x4 = num2str(int32(changebox(7)));
        xmlcontent.annotation.object(j).polygon.y4 = num2str(int32(changebox(8)));
       
        %绘图
%         plot([x1,x2,x3,x4,x1],[y1,y2,y3,y4,y1],'b')
%         plot([changebox(1:2:end)',changebox(1)],[changebox(2:2:end)',changebox(2)],'r')
    end
%     hold off
%     title(xmlfilename)
%     saveas(h,strcat('screencrop/',xmlfilename))
%     close all
     outputpath = strcat('output/',xmlfilename(1:end-4),'.xml');
     VOCwritexml(xmlcontent, outputpath)
end