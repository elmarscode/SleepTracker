clear
%%http://www.mathworks.com/matlabcentral/answers/27408-reading-a-csv-file-with-header-and-times
%%https://www.gnu.org/software/octave/doc/interpreter/Timing-Utilities.html

rescanFile = 0;                       % 0-do not rescan, 1-rescan data file
backupData = 1;                       % 0-do not replace old backup file
                                      % 1-replace backup file
MAX_BUFFER_SIZE = 100000;             % Max amount of samples to read in
readBufferSize = MAX_BUFFER_SIZE;     
total2read = 5000000;                 % Total number of samples to read
formatSpec = '%s %*s %f %f %f';       % Format of data in file
filename = 'H.txt';                   % Data filename
fileDataBackup = 'H_data.mat';        % Variable back up file name
%things2save = {"'T'";"'xm'";"'ym'";"'zm'"}; % Variables to back up [Not functional]
if readBufferSize > total2read        % If there's less samples then you 
  readBufferSize = total2read;        % you want to buffer, read in total
end
tCol = 1;
xCol = 2;
yCol = 3;
zCol = 4;
T=[];
F=[];
fidData = fopen(fileDataBackup); %if data exist do not rescan unless rescan = 1;
if (fidData == -1) || rescanFile
  fid = fopen(filename);
  head=1;
  tail=1;
  keepFeeding = 1;
  j=0;
  while ~feof(fid) && (total2read>0)
      DATA = textscan(fid,formatSpec, readBufferSize, 'delimiter' , ',');
      if length(DATA{1,1}) && (total2read>0)
        T=[T;DATA{:,tCol}];
        F=[F;[DATA{:,xCol},DATA{:,yCol},DATA{:,zCol}]];
        samplesRead = length(DATA{1,1});
        total2read = total2read - samplesRead;
        clear DATA;
        for i = 1:(samplesRead-1)
          pastTime = strptime(T(i), "%Y/%m/%d %T").sec;
          currentTime = strptime(T(i+1), "%Y/%m/%d %T").sec;
          if (pastTime == currentTime)
            tail=tail+1;
          else
            j=j+1;
            pastTime = T(i+1);
            xm(j) = mean(F(head:tail,1),1);
            ym(j) = mean(F(head:tail,2),1);
            zm(j) = mean(F(head:tail,3),1);
            tail = tail+1;
            head = tail;
          end
        end
      end
  end
  fclose(fid);
else
  %if ~(fidData == -1)
     fclose(fidData);
  %end
  load(fileDataBackup);  
end
if backupData
  save(fileDataBackup, 'T', 'xm', 'ym', 'zm');
end
clear T F;
%DisplayRaw
DeltaRectify
