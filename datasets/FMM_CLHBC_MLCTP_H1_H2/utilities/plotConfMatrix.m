function plotConfMatrix(M, labelX, labelY)
fontSize = 12;
format short
if nargin < 3
  labelY = {'SFR','SFL','SNR','SNL','BIF','BOF','BIN','BON','HF','HN','BIFSR','BIFSL','BOFS','BINSR','BINSL','BONS','NET', 'Ins'};
  if nargin < 2
    labelX = {'SFR','SFL','SNR','SNL','BIF','BOF','BIN','BON','HF','HN','BIFSR','BIFSL','BOFS','BINSR','BINSL','BONS', 'Del'};
  end
end

SHOW_PERCENTAGE = false;
[ROWS, COLS] = size(M);
imRows = 20*ROWS;
if SHOW_PERCENTAGE
    imCols = 50*COLS;
else
    imCols = 40*COLS;
end
confImg = zeros(imRows,imCols);

for r=1:ROWS
    for c=1:COLS
        imR = [1:imRows/ROWS]+(r-1)*imRows/ROWS;
        imC = [1:imCols/COLS]+(c-1)*imCols/COLS;
        [gR gC] = meshgrid(imR,imC);
        idx = sub2ind([imRows, imCols], gR, gC);
        confImg(idx) = ones(imRows/ROWS,imCols/COLS) * M(r,c)/sum(M(r,:));
    end
end
% imagesc(confImg);
imshow(confImg);
myColorMap = hot;
myColorMap = myColorMap(end:-1:1, :);
colormap(myColorMap);
hold on
for r=1:ROWS
    for c=1:COLS
        imR = mean([1,imRows/ROWS]+(r-1)*imRows/ROWS);
        imC = mean([1,imCols/COLS]+(c-1)*imCols/COLS);
        proportion = M(r,c)/sum(M(r,:));
        colour =  [1 1 1]-myColorMap(min(1+floor(size(myColorMap,1)*proportion),256),:);
        if M(r,c) > 0.01 % only shows numbers when they're not zero
            if SHOW_PERCENTAGE
                str = sprintf('%0.2f (%0.2f)', M(r,c), round(100*proportion));
            else
                str = sprintf('%0.2f', M(r,c));
            end
            text(imC, imR, str, 'Color',colour, 'HorizontalAlignment', 'center', 'FontSize', fontSize-2)
        end
    end
end
set(gca,'Visible','on')

set(gca,'XTick', 0.5*imCols/COLS : imCols/COLS : imCols);
set(gca,'XTickLabel', labelX, 'FontSize', fontSize)
set(gca,'XAxisLocation', 'top')
xticklabel_rotate([], 30,[],'FontSize',fontSize,'FontWeight',get(gca,'FontWeight'));

set(gca,'YTick', 0.5*imRows/ROWS : imRows/ROWS : imRows);
set(gca,'YTickLabel', labelY, 'FontSize', fontSize)

% title('Confusion Matrix','FontSize', 12)
%xlabel('Response','FontSize', fontSize, 'VerticalAlignment','bottom', 'Position', [.5, 1.15])
% text(imCols/2, -2*(fontSize/11)*imRows/ROWS, 'Response', 'HorizontalAlignment', 'center', 'FontSize', fontSize,'VerticalAlignment','bottom')
%ylabel('Stimulus','FontSize', fontSize,'VerticalAlignment','bottom', 'Position', [-.095 .5 0])
% text(-1.5*(fontSize/11)*imCols/COLS, imRows/2, 'Stimulus', 'HorizontalAlignment', 'center', 'FontSize', fontSize, 'Rotation', 90,'VerticalAlignment','bottom')


% Word accuracy: (N-D-S-I)/N (N=total number of true events, D=deletions, I=insertions, S=substitutions)
% can also be calculated as (H-I)/N, (H=correctly classified samples)
trueSamples = sum(sum(M(1:ROWS,:)));
insertions = 0;
deletions = 0;
correct = sum(diag(M(1:ROWS,1:COLS)));
accuracy = 100*(correct-insertions)/trueSamples;
subsMap = ~eye(ROWS,COLS);
subsMap(end,:) = false;
subsMap(:,end) = false;
substitutions = sum(sum(M(subsMap)));

% Precision: TP/(TP+FP)
precision = 100*correct/(trueSamples-deletions+insertions);

recall = 100*correct/(correct+deletions+substitutions);

%str = sprintf('precision=%4.2f  recall=%4.2f  accuracy=%4.2f', precision, recall, accuracy);
%text(imCols/2, imRows/ROWS+imRows, str, 'HorizontalAlignment', 'center', 'FontSize', fontSize-2);
% title(str)

end